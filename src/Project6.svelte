<script lang="ts">
    import ProgressBar from './progress_bar.svelte';
    import ColoringBg from './coloring_bg.svelte';
    import Sorting from './sorting.svelte';
    let csvData: { column1: string; column3: string; column4: string; column5: string; column6: string }[] = [];
    let sortColumn: 'column3' | 'column4' | 'column5' | 'column6' | null = null;
    let sortDirection: 'asc' | 'desc' = 'asc';
  
    async function fetchCSV() {
      const response = await fetch('src/assets/to_test_complexity.csv');
      const csvBlob = await response.blob();
      const csvText = await new Response(csvBlob).text();
      csvData = parseCSV(csvText);
    }
  
    function parseCSV(csvText: string): { column1: string; column3: string; column4: string; column5: string; column6: string }[] {
      const rows = csvText.trim().split('\n');
      const uniqueContainers: { [key: string]: { column1: string; column3: number[]; column4: number[]; column5: number[]; column6: number[] } } = {};
  
      rows.forEach((row) => {
        const columns = row.split(',');
        const container = columns[0];
  
        if (!uniqueContainers[container]) {
          uniqueContainers[container] = {
            column1: container,
            column3: [],
            column4: [],
            column5: [],
            column6: [],
          };
        }
  
        uniqueContainers[container].column3.push(parseFloat(columns[2]));
        uniqueContainers[container].column4.push(parseFloat(columns[3]));
        uniqueContainers[container].column5.push(parseFloat(columns[4]));
        uniqueContainers[container].column6.push(parseFloat(columns[5]));
      });
  
      return Object.values(uniqueContainers).map(({ column1, column3, column4, column5, column6 }) => ({
        column1,
        column3: ((column3.reduce((sum, val) => sum + val, 0) / column3.length) || 0).toFixed(1),
        column4: ((column4.reduce((sum, val) => sum + val, 0) / column4.length) || 0).toFixed(1),
        column5: ((column5.reduce((sum, val) => sum + val, 0) / column5.length) || 0).toFixed(1),
        column6: ((column6.reduce((sum, val) => sum + val, 0) / column6.length) || 0).toFixed(1),
      }));
    }
  
    $: sortedData = sortColumn
      ? csvData.sort((a, b) => {
        const aValue = parseFloat(a[sortColumn as keyof typeof a]);
        const bValue = parseFloat(b[sortColumn as keyof typeof b]);
          return sortDirection === 'asc' ? aValue - bValue : bValue - aValue;
        })
      : csvData;
  
    function handleSort(column: 'column3' | 'column4' | 'column5' | 'column6') {
      if (sortColumn === column) {
        sortDirection = sortDirection === 'asc' ? 'desc' : 'asc';
      } else {
        sortColumn = column;
        sortDirection = 'asc';
      }
    }
  
    fetchCSV();
  </script>
  
  <div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start">
        <a href="/projects" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to project list...</a>
    </div>
    <div class="flex justify-between items-start">
      <div class="flex flex-col">
        <h1 class="text-2xl font-bold mt-2">The coverage report for all containers</h1>
        <h1 class="text-xl mt-2">
            <span class="text-xl font-bold"> Test date:</span>  
            <span class="text-xl"> 2024-July-28 00:00:00</span>
        </h1>
        <h2 class="text-xl font-bold mt-2">
          <span class="text-xl"> Rating: </span> 
          <span class="px-2 py-1 text-sm" style="background-color: red; color: black;">Low: &lt; 75%</span>
          <span class="px-2 py-1 text-sm" style="background-color: yellow; color: black;">Medium: ≥ 75%</span>
          <span class="px-2 py-1 text-sm" style="background-color: green; color: black;">High: ≥ 90%</span>
        </h2>
      </div>
      <div class="flex flex-col items-end">
        <table>
          <thead>
            <tr class="text-lg divide-x border-2">
                <th></th>
                <th scope="col" class="px-2 py-1">Decision</th>
                <th scope="col" class="px-2 py-1">Condition</th>
                <th scope="col" class="px-2 py-1">Execution</th>
            </tr>
          </thead>
          <tbody>
            <tr class="px-2 py-1 text-lg divide-x border-2">
                <td class="px-2 py-1 font-bold">
                  Total Coverage
                </td>
                <td> 
                  <ColoringBg value={(csvData.reduce((sum, row) => sum + parseFloat(row.column3), 0) / csvData.length).toFixed(1)}/>
                </td>
                <td>
                  <ColoringBg value={(csvData.reduce((sum, row) => sum + parseFloat(row.column4), 0) / csvData.length).toFixed(1)}/>
                </td>
                <td>
                  <ColoringBg value={(csvData.reduce((sum, row) => sum + parseFloat(row.column5), 0) / csvData.length).toFixed(1)}/>
                </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  
   
    <div class="overflow-x-auto">
      <table class="w-full mt-4 text-lg border-2">
        <thead>
          <tr class="divide-x text-lg">
            <th scope="col" rowspan="2">
              Repositories
            </th>
            <th scope="col" rowspan="2">
              <Sorting
                label="Complexity"
                {sortColumn}
                {sortDirection}
                onSort={() => handleSort('column6')}
                />
            </th>
            <th colspan="2">
              <Sorting 
                label="Decision coverage"
                {sortColumn}
                {sortDirection}
                onSort={() => handleSort('column3')}
                />
            </th>
            <th colspan="2">
              <Sorting 
                label="Condition coverage"
                {sortColumn}
                {sortDirection}
                onSort={() => handleSort('column4')}
              />
            </th>
            <th colspan="2">
              <Sorting 
                label="Execution coverage"
                {sortColumn}
                {sortDirection}
                onSort={() => handleSort('column5')}
              />
            </th>
          </tr>
          <tr class="divide-x border-2 text-lg">
            <th class="border-l-2" scope="col">Rate bar</th>
            <th scope="col">Rate %</th>
            <th scope="col">Rate bar</th>
            <th scope="col">Rate %</th>
            <th scope="col">Rate bar</th>
            <th scope="col">Rate %</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-x divide-gray-100">
          {#each sortedData as row}
            <tr>
              <td class="px-2 border-r-2 text-lg">
                <a href="/project6a?container={row.column1}" class="hover:underline hover:bg-[rgba(44,188,255,0.4)]">
                    {#if row.column1 === 'con-audio-alarms'}
                        {row.column1} <span class="text-gray-400">(2024-May-08 14:33:34)</span>
                    {:else if row.column1 === 'con-aux-speed-indicator'}
                        {row.column1} <span class="text-gray-400">(2024-May-12 15:25:02)</span>
                    {:else if row.column1 === 'con-rail-adhesion'}
                        {row.column1} <span class="text-gray-400">(2024-May-14 13:58:39)</span>
                    {:else if row.column1 === 'con-lights-control'}
                        {row.column1} <span class="text-gray-400">(2024-May-14 13:06:39)</span>
                    {:else if row.column1 === 'con-air-brake-management'}
                        {row.column1} <span class="text-gray-400">(2024-May-17 14:37:44)</span>
                    {:else if row.column1 === 'con-aux-inverter-control'}
                        {row.column1} <span class="text-gray-400">(2024-May-18 12:35:34)</span>
                    {:else if row.column1 === 'con-event-recorder'}
                        {row.column1} <span class="text-gray-400">(2024-May-21 10:36:48)</span>
                    {:else if row.column1 === 'con-display'}
                        {row.column1} <span class="text-gray-400">(2024-May-22 13:42:20)</span>
                    {:else if row.column1 === 'con-high-voltage-aux-bus'}
                        {row.column1} <span class="text-gray-400">(2024-May-31 17:44:09)</span>
                    {:else if row.column1 === 'con-axle-powerup'}
                        {row.column1} <span class="text-gray-400">(2024-May-31 19:28:43)</span>
                    {:else if row.column1 === 'con-aux-equipment'}
                        {row.column1} <span class="text-gray-400">(2024-July-09 02:33:49)</span>
                    {:else if row.column1 === 'con-energy-storage'}
                        {row.column1} <span class="text-gray-400">(2024-Jun-19 13:30:46)</span>
                    {:else if row.column1 === 'con-locomotive-speed'}
                        {row.column1} <span class="text-gray-400">(2024-Jun-09 17:10:54)</span>
                    {:else if row.column1 === 'con-locomotive-control'}
                        {row.column1} <span class="text-gray-400">(2024-Jun-13 15:01:10)</span>
                    {:else if row.column1 === 'con-high-voltage'}
                        {row.column1} <span class="text-gray-400">(2024-Jun-16 20:34:59)</span>
                    {:else if row.column1 === 'con-torque'}
                        {row.column1} <span class="text-gray-400">(2024-Jun-29 01:49:55)</span>
                    {:else if row.column1 === 'con-audio-alarm'}
                        {row.column1} <span class="text-gray-400">(2024-May-08 14:33:34)</span>
                    {:else}
                        {row.column1} <span class="text-yellow-400">(no test cases)</span>
                    {/if}
                  </a>
              </td>
              <td class="px-2 border-2">
                {row.column6}
              </td>
              <td> 
                <ProgressBar value={row.column3}/>  
              </td>
              <td class="border-2">
                <ColoringBg value={row.column3}/>
              </td>
              <td>
                <ProgressBar value={row.column4}/>
              </td>
              <td class="border-2">
                <ColoringBg value={row.column4}/>
              </td>
              <td>
                <ProgressBar value={row.column5}/>
              </td>
              <td class="border-2">
                <ColoringBg value={row.column5}/>
              </td>
            </tr>
          {/each}
        </tbody>
      </table>
    </div>
  </div>