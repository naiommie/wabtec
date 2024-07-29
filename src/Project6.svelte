<script lang="ts">
    let csvData: { column1: string; column3: string; column4: string; column5: string }[] = [];
    let sortColumn: 'column3' | 'column4' | 'column5' | null = null;
    let sortDirection: 'asc' | 'desc' = 'asc';
  
    async function fetchCSV() {
      const response = await fetch('src/assets/coverage_results.csv');
      const csvBlob = await response.blob();
      const csvText = await new Response(csvBlob).text();
      csvData = parseCSV(csvText);
    }
  
    function parseCSV(csvText: string): { column1: string; column3: string; column4: string; column5: string }[] {
      const rows = csvText.trim().split('\n');
      const uniqueContainers: { [key: string]: { column1: string; column3: number[]; column4: number[]; column5: number[] } } = {};
  
      rows.forEach((row) => {
        const columns = row.split(',');
        const container = columns[0];
  
        if (!uniqueContainers[container]) {
          uniqueContainers[container] = {
            column1: container,
            column3: [],
            column4: [],
            column5: [],
          };
        }
  
        uniqueContainers[container].column3.push(parseFloat(columns[2]));
        uniqueContainers[container].column4.push(parseFloat(columns[3]));
        uniqueContainers[container].column5.push(parseFloat(columns[4]));
      });
  
      return Object.values(uniqueContainers).map(({ column1, column3, column4, column5 }) => ({
        column1,
        column3: ((column3.reduce((sum, val) => sum + val, 0) / column3.length) || 0).toFixed(1),
        column4: ((column4.reduce((sum, val) => sum + val, 0) / column4.length) || 0).toFixed(1),
        column5: ((column5.reduce((sum, val) => sum + val, 0) / column5.length) || 0).toFixed(1),
      }));
    }
  
    $: sortedData = sortColumn
      ? csvData.sort((a, b) => {
        const aValue = parseFloat(a[sortColumn as keyof typeof a]);
        const bValue = parseFloat(b[sortColumn as keyof typeof b]);
          return sortDirection === 'asc' ? aValue - bValue : bValue - aValue;
        })
      : csvData;
  
    function handleSort(column: 'column3' | 'column4' | 'column5') {
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
        <h1 class="text-2xl font-bold mt-2">Coverage report</h1>
        <h1 class="text-xl mt-2">
            <span class="text-xl font-bold"> Created date:</span>  
            <span class="text-xl"> 2024-July-26 10:38:53</span>
        </h1>
        <h2 class="text-xl font-bold mt-2">
          <span class="text-xl"> Rating: </span> 
          <span class="px-2 py-1 text-sm" style="background-color: red; color: black;">Low: &lt; 75%</span>
          <span class="px-2 py-1 text-sm" style="background-color: yellow; color: black;">Medium: ≥ 75%</span>
          <span class="px-2 py-1 text-sm" style="background-color: green; color: black;">High: ≥ 90%</span>
        </h2>
      </div>
      <div class="flex flex-col items-end">
        <table class="border-2 border-gray-100 text-lg">
          <thead>
            <tr class="divide-x divide-y border-b-2 border-gray-100 text-gray-100">
                <th></th>
              <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Decision</th>
              <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Condition</th>
              <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Execution</th>
            </tr>
          </thead>
          <tbody>
            <tr class="divide-x divide-y border-b-2 border-gray-100 text-gray-100">
                <td class="px-2 py-1 text-center text-lg border-2 font-bold border-gray-100">Total Coverage</td>
                <td class="px-2 py-1 text-center text-lg border-2 border-gray-100" style="background-color: {(csvData.reduce((sum, row) => sum + parseFloat(row.column3), 0) / csvData.length) < 75 ? 'red' : (csvData.reduce((sum, row) => sum + parseFloat(row.column3), 0) / csvData.length) >= 75 && (csvData.reduce((sum, row) => sum + parseFloat(row.column3), 0) / csvData.length) < 90 ? 'yellow' : 'green'}; color: black; font-weight: bold;">
                {(csvData.reduce((sum, row) => sum + parseFloat(row.column3), 0) / csvData.length).toFixed(1)}%
                </td>
                <td class="px-2 py-1 text-center text-lg border-2 border-gray-100" style="background-color: {(csvData.reduce((sum, row) => sum + parseFloat(row.column4), 0) / csvData.length) < 75 ? 'red' : (csvData.reduce((sum, row) => sum + parseFloat(row.column4), 0) / csvData.length) >= 75 && (csvData.reduce((sum, row) => sum + parseFloat(row.column4), 0) / csvData.length) < 90 ? 'yellow' : 'green'}; color: black; font-weight: bold;">
                {(csvData.reduce((sum, row) => sum + parseFloat(row.column4), 0) / csvData.length).toFixed(1)}%
                </td>
                <td class="px-2 py-1 text-center text-lg border-2 border-gray-100" style="background-color: {(csvData.reduce((sum, row) => sum + parseFloat(row.column5), 0) / csvData.length) < 75 ? 'red' : (csvData.reduce((sum, row) => sum + parseFloat(row.column5), 0) / csvData.length) >= 75 && (csvData.reduce((sum, row) => sum + parseFloat(row.column5), 0) / csvData.length) < 90 ? 'yellow' : 'green'}; color: black; font-weight: bold;">
                {(csvData.reduce((sum, row) => sum + parseFloat(row.column5), 0) / csvData.length).toFixed(1)}%
                </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  
   
    <div class="overflow-x-auto">
      <table class="w-full mt-4 text-lg border-2 border-gray-100">
        <thead>
          <tr class="divide-x divide-y border-b-2 border-gray-100 text-gray-100">
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100" rowspan="2">Repositories</th>
            <th
              scope="col"
              class="px-2 py-1 text-center text-lg border-2 border-gray-100 cursor-pointer"
              colspan="2"
              on:click={() => handleSort('column3')}
            >
              Decision coverage {sortColumn === 'column3' ? (sortDirection === 'asc' ? '⬆' : '⬇') : '⬆⬇'}
            </th>
            <th
              scope="col"
              class="px-2 py-1 text-center text-lg border-2 border-gray-100 cursor-pointer"
              colspan="2"
              on:click={() => handleSort('column4')}
            >
              Condition coverage {sortColumn === 'column4' ? (sortDirection === 'asc' ? '⬆' : '⬇') : '⬆⬇'}
            </th>
            <th
              scope="col"
              class="px-2 py-1 text-center text-lg border-2 border-gray-100 cursor-pointer"
              colspan="2"
              on:click={() => handleSort('column5')}
            >
              Execution coverage {sortColumn === 'column5' ? (sortDirection === 'asc' ? '⬆' : '⬇') : '⬆⬇'}
            </th>
          </tr>
          <tr class="divide-x divide-y border-b-2 border-gray-100 text-gray-100">
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Rate bar</th>
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Rate %</th>
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Rate bar</th>
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Rate %</th>
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Rate bar</th>
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Rate %</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-x divide-gray-100">
          {#each sortedData as row}
          
            <tr class="border-b-2 border-gray-100">
              <td class="px-2 py-1 whitespace-pre-line text-lg border-r-2 border-gray-100">
                <a href="/project6a?container={row.column1}" class="underline hover:bg-[rgba(44,188,255,0.4)]">
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
                        {row.column1} <span class="text-yellow-400">(No test cases)</span>
                    {/if}
                  </a>
              </td>
              <td class="px-2 py-1 whitespace-pre-line text-lg border-r-2 border-b-2 border-gray-100">
                <div class="w-full h-4 bg-gray-300 rounded">
                  <div
                    class="h-full rounded transition-all duration-300"
                    style="width: {parseFloat(row.column3) / 100 * 100}%; background-color: {parseFloat(row.column3) < 75 ? 'red' : parseFloat(row.column3) >= 75 && parseFloat(row.column3) < 90 ? 'yellow' : 'green'}"
                  ></div>
                </div>
              </td>
              <td class="px-2 py-1 whitespace-pre-line text-lg border-r-2 border-b-2 border-gray-100" style="background-color: {parseFloat(row.column3) < 75 ? 'red' : parseFloat(row.column3) >= 75 && parseFloat(row.column3) < 90 ? 'yellow' : 'green'}; color: black; font-weight: bold;">{row.column3}%</td>
              <td class="px-2 py-1 whitespace-pre-line text-lg border-r-2 border-b-2 border-gray-100">
                <div class="w-full h-4 bg-gray-300 rounded">
                  <div
                    class="h-full rounded transition-all duration-300"
                    style="width: {parseFloat(row.column4) / 100 * 100}%; background-color: {parseFloat(row.column4) < 75 ? 'red' : parseFloat(row.column4) >= 75 && parseFloat(row.column4) < 90 ? 'yellow' : 'green'}"
                  ></div>
                </div>
              </td>
              <td class="px-2 py-1 whitespace-pre-line text-lg border-r-2 border-b-2 border-gray-100" style="background-color: {parseFloat(row.column4) < 75 ? 'red' : parseFloat(row.column4) >= 75 && parseFloat(row.column4) < 90 ? 'yellow' : 'green'}; color: black; font-weight: bold;">{row.column4}%</td>
              <td class="px-2 py-1 whitespace-pre-line text-lg border-r-2 border-b-2 border-gray-100">
                <div class="w-full h-4 bg-gray-300 rounded">
                  <div
                    class="h-full rounded transition-all duration-300"
                    style="width: {parseFloat(row.column5) / 100 * 100}%; background-color: {parseFloat(row.column5) < 75 ? 'red' : parseFloat(row.column5) >= 75 && parseFloat(row.column5) < 90 ? 'yellow' : 'green'}"
                  ></div>
                </div>
              </td>
              <td class="px-2 py-1 whitespace-pre-line text-lg border-r-2 border-b-2 border-gray-100" style="background-color: {parseFloat(row.column5) < 75 ? 'red' : parseFloat(row.column5) >= 75 && parseFloat(row.column5) < 90 ? 'yellow' : 'green'}; color: black; font-weight: bold;">{row.column5}%</td>
            </tr>
          {/each}
        </tbody>
      </table>
    </div>
  </div>