<script lang="ts">
    let csvData: { column1: string; column2: string }[] = [];
  
    async function fetchCSV() {
      const response = await fetch('src/assets/coverage_results.csv');
      const csvBlob = await response.blob();
      const csvText = await new Response(csvBlob).text();
      csvData = parseCSV(csvText);
    }
  
    function parseCSV(csvText: string): { column1: string; column2: string }[] {
      const rows = csvText.trim().split('\n');
      return rows.map((row) => {
        const columns = [];
        let currentColumn = '';
        let inQuotes = false;
  
        for (let i = 0; i < row.length; i++) {
          const char = row[i];
  
          if (char === '"') {
            inQuotes = !inQuotes;
          } else if (char === ',' && !inQuotes) {
            columns.push(currentColumn.trim());
            currentColumn = '';
          } else {
            currentColumn += char;
          }
        }
  
        columns.push(currentColumn.trim());
        return { column1: columns[0], column2: columns[1] };
      });
    }
  
    fetchCSV();
  </script>
  
  <div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start">
      <a href="/projects" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to project list...</a>
    </div>
  
    <h1 class="text-2xl font-bold mt-4">SES RAT vs QVScribe requirement tools comparison</h1>
    
  
    <h2 class="text-xl font-bold mt-4">Results</h2>
    <div class="overflow-x-auto">
      <table class="w-full mt-4 text-xs border-2 border-gray-100">
        <thead>
          <tr class="divide-x divide-y border-b-2 border-gray-100 text-gray-100">
            <th scope="col" class="px-2 py-1 text-center text-xs font-medium border-2 border-gray-100 ">#</th>
            <th scope="col" class="px-2 py-1 text-center text-xs font-medium border-2 border-gray-100 ">QVscribe summary</th>
            <th scope="col" class="px-2 py-1 text-center text-xs font-medium border-2 border-gray-100 ">SES summary</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-x divide-gray-100">
          {#each csvData.entries() as [index, row]}
            <tr class="border-b-2 border-gray-100">
              <td class="px-2 py-1 whitespace-pre-line text-xs border-r-2 border-gray-100 ">{row.column1}</td>
              <td class="px-2 py-1 whitespace-pre-line text-xs border-b-2 border-r-2 border-gray-100">100</td>
              <td class="px-2 py-1 whitespace-pre-line text-xs border-r-2 border-b-2 border-gray-100">{row.column2}</td>
            </tr>
          {/each}
        </tbody>
      </table> 
    </div>
  </div>


