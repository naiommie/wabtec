<script lang="ts">
    import { onMount } from 'svelte';
    import ColoringBg from './coloring_bg.svelte';
  
    let csvData: { column2: string; column3: string; column4: string; column5: string; column6: string }[] = [];
    let selectedContainer: string | null = null;
  
    onMount(async () => {
      const url = new URL(window.location.href);
      selectedContainer = url.searchParams.get('container');
      await fetchCSV(selectedContainer);
    });
  
    async function fetchCSV(selectedContainer: string | null = null) {
      const response = await fetch('src/assets/to_test_complexity.csv');
      const csvBlob = await response.blob();
      const csvText = await new Response(csvBlob).text();
      csvData = parseCSV(csvText, selectedContainer);
    }
  
    function parseCSV(csvText: string, selectedContainer: string | null = null): { column2: string; column3: string; column4: string; column5: string; column6: string }[] {
      const rows = csvText.trim().split('\n');
      const filteredData = selectedContainer
        ? rows.filter((row) => row.startsWith(selectedContainer))
        : rows;
  
      return filteredData.map((row) => {
        const columns = row.split(',');
        return {
          column2: columns[1],
          column3: columns[2],
          column4: columns[3],
          column5: columns[4],
          column6: columns[5],
        };
      });
    }
  </script>
  
  <div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start">
        <a href="/project6" class="btn hover:bg-[rgba(255,255,255,0.75)]">Back to container list...</a>
    </div>
    <div class="flex justify-between items-start">
      <div class="flex flex-col">
        <h1 class="text-2xl font-bold mt-2">
          Model(s) of "{selectedContainer}"
        </h1>
        <h1 class="text-xl mt-2">
            <span class="text-xl font-bold"> Test date:</span>  
            <span class="text-xl"> 
              {#if selectedContainer === 'con-audio-alarms'}
                2024-May-08 14:33:34
              {:else if selectedContainer === 'con-aux-speed-indicator'}
                2024-May-12 15:25:02
              {:else if selectedContainer === 'con-rail-adhesion'}
                2024-May-14 13:58:39
              {:else if selectedContainer === 'con-lights-control'}
                2024-May-14 13:06:39
              {:else if selectedContainer === 'con-air-brake-management'}
                2024-May-17 14:37:44
              {:else if selectedContainer === 'con-aux-inverter-control'}
                2024-May-18 12:35:34
              {:else if selectedContainer === 'con-event-recorder'}
                2024-May-21 10:36:48
              {:else if selectedContainer === 'con-display'}
                2024-May-22 13:42:20
              {:else if selectedContainer === 'con-high-voltage-aux-bus'}
                2024-May-31 17:44:09
              {:else if selectedContainer === 'con-axle-powerup'}
                2024-May-31 19:28:43
              {:else if selectedContainer === 'con-aux-equipment'}
                2024-July-09 02:33:49
              {:else if selectedContainer === 'con-energy-storage'}
                2024-Jun-19 13:30:46
              {:else if selectedContainer === 'con-locomotive-speed'}
                2024-Jun-09 17:10:54
              {:else if selectedContainer === 'con-locomotive-control'}
                2024-Jun-13 15:01:10
              {:else if selectedContainer === 'con-high-voltage'}
                2024-Jun-16 20:34:59
              {:else if selectedContainer === 'con-torque'}
                2024-Jun-29 01:49:55
              {:else if selectedContainer === 'con-audio-alarm'}
                2024-May-08 14:33:34
              {:else}
                (no test cases)
              {/if}
            </span>
        </h1>
        <h2 class="text-xl font-bold mt-2">
          <span class="text-xl"> Rating: </span> 
          <span class="px-2 py-1 text-sm" style="background-color: red; color: white;">Low: &lt; 75%</span>
          <span class="px-2 py-1 text-sm" style="background-color: yellow; color: black;">Medium: ≥ 75%</span>
          <span class="px-2 py-1 text-sm" style="background-color: green; color: white;">High: ≥ 90%</span>
        </h2>
      </div>
      <div class="flex flex-col items-end">
        <table class="border-2 text-lg">
          <thead>
            <tr class="divide-x border-2">
              <th></th>
              <th scope="col" class="px-2 py-1">Decision</th>
              <th scope="col" class="px-2 py-1">Condition</th>
              <th scope="col" class="px-2 py-1">Execution</th>
            </tr>
          </thead>
          <tbody>
            <tr class="px-2 py-1 font-bold text-lg divide-x">
                <td class="px-2">
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
          <tr class="divide-x border-2">
            <th scope="col">Repositories</th>
            <th scope="col">Complexity</th>
            <th scope="col">Decision coverage</th>
            <th scope="col">Condition coverage</th>
            <th scope="col">Execution coverage</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-x">
          {#each csvData as row}
            <tr class="divide-x">
              <td class="px-2 py-1">
                {row.column2}
              </td>
              <td class="px-2 py-1">
                {row.column6}
              </td>
              <td class="border-2">
                <ColoringBg value={row.column3}/>
              </td>
              <td class="border-2">
                <ColoringBg value={row.column4}/>
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