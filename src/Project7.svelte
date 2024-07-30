<script lang="ts">
    let csvData: { column1: string; column3: string; column4: string; column5: string }[] = [];
    let sortColumn: 'column3' | 'column4' | 'column5' | null = null;
    let sortDirection: 'asc' | 'desc' = 'asc';
    let selectedFile: 'coverage_master' | 'coverage_develop' | 'coverage_latest' = 'coverage_master';
  
    async function fetchCSV() {
        const response = await fetch(`src/assets/${selectedFile}.csv`);
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

    function handleFileChange(file: 'coverage_master' | 'coverage_develop' | 'coverage_latest') {
   selectedFile = file;
   fetchCSV();
 }
  
    fetchCSV();
  </script>
  
  <div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start">
        <a href="/projects" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to project list...</a>
    </div>
    <h1 class="text-2xl font-bold mt-2">Please select the branch</h1>
    <div class="m-4 flex space-x-2">
        
             <button
               class="px-4 py-2 rounded text-white "
               class:bg-green-500={selectedFile === 'coverage_master'}
               class:bg-transparent={selectedFile !== 'coverage_master'}
               on:click={() => handleFileChange('coverage_master')}
             >
               master
             </button>
             <button
               class="px-4 py-2 rounded text-white"  
               class:bg-green-500={selectedFile === 'coverage_develop'}
               class:bg-transparent={selectedFile !== 'coverage_develop'}
               on:click={() => handleFileChange('coverage_develop')}
             >
               develop
             </button>
             <button
               class:bg-green-500={selectedFile === 'coverage_latest'}
               class:bg-transparent={selectedFile !== 'coverage_latest'}
               class="px-4 py-2 rounded text-white"
               on:click={() => handleFileChange('coverage_latest')}
             >
                release_flx_rhi_swr2
             </button>
           </div>
    <div class="flex justify-between items-start">
      <div class="flex flex-col">
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
                <a href="/project6a_{selectedFile}?container={row.column1}" class="hover:underline hover:bg-[rgba(44,188,255,0.4)]">
                    {row.column1} 
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