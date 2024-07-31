<script lang="ts">
    import { onMount } from 'svelte';
    import ProgressBar from './progress_bar.svelte';
    import ColoringBg from './coloring_bg.svelte';
    import Sorting from './sorting.svelte';
  
    let csvData: { column2: string; column3: string; column4: string; column5: string }[] = [];
    let selectedContainer: string | null = null;
  
    onMount(async () => {
      const url = new URL(window.location.href);
      selectedContainer = url.searchParams.get('container');
      await fetchCSV(selectedContainer);
    });
  
    async function fetchCSV(selectedContainer: string | null = null) {
      const response = await fetch('src/assets/coverage_results.csv');
      const csvBlob = await response.blob();
      const csvText = await new Response(csvBlob).text();
      csvData = parseCSV(csvText, selectedContainer);
    }
  
    function parseCSV(csvText: string, selectedContainer: string | null = null): { column2: string; column3: string; column4: string; column5: string }[] {
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
        <h1 class="text-2xl font-bold mt-2">Coverage report</h1>
        <h1 class="text-xl mt-2">
            <span class="text-xl font-bold"> Test date:</span>  
            <span class="text-xl"> 2024-01-27 18:03:53</span>
        </h1>
        <h2 class="text-xl font-bold mt-2">
          <span class="text-xl"> Rating: </span> 
          <span class="px-2 py-1 text-sm" style="background-color: red; color: white;">Low: &lt; 75%</span>
          <span class="px-2 py-1 text-sm" style="background-color: yellow; color: black;">Medium: ≥ 75%</span>
          <span class="px-2 py-1 text-sm" style="background-color: green; color: white;">High: ≥ 90%</span>
        </h2>
      </div>
      <div class="flex flex-col items-end">
        <table class="border-2 border-gray-100 text-lg">
          <thead>
            <tr class="divide-x divide-y border-b-2 border-gray-100 text-gray-100">
                <th></th>
              <th scope="col" class="px-2 py-1">Decision</th>
              <th scope="col" class="px-2 py-1">Condition</th>
              <th scope="col" class="px-2 py-1">Execution</th>
            </tr>
          </thead>
          <tbody>
            <tr class="px-2 py-1 text-center text-lg divide-x divide-y border-2 border-gray-100 text-gray-100">
                <td class="px-2 py-1 font-bold">Total Coverage</td>
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
      <table class="w-full mt-4 text-lg border-2 border-gray-100">
        <thead>
          <tr class="divide-x divide-y border-b-2 border-gray-100 text-gray-100">
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Repositories</th>
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Decision coverage</th>
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Condition coverage</th>
            <th scope="col" class="px-2 py-1 text-center text-lg border-2 border-gray-100">Execution coverage</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-x divide-gray-100">
          {#each csvData as row}
            <tr class="border-b-2 border-gray-100">
              <td class="px-2 py-1 whitespace-pre-line text-lg border-r-2 border-gray-100">{row.column2}</td>
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