<script>
    const toolComparison = [
      {
        tool: 'QVscribe',
        complexity: 'Moderate',
        clicks: '20',
        timeSpent: '~16 minutes',
        correctness: 'Highlights wrong words, provides score summary and common problems. Allows fixing issues within the tool.'
      },
      {
        tool: 'SES RAT',
        complexity: 'High',
        clicks: '15',
        timeSpent: '~33 minutes 10 seconds',
        correctness: 'Allows creating quality assessment columns in Excel, but the process is more involved.'
      }
    ];
  </script>
  

  <div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start">
        <a href="/projects" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to project list...</a>
    </div>

    <h1 class="text-2xl font-bold mt-4 mb-4">SES RAT vs QVScribe requirement tools comparison</h1>

    <div class="overflow-x-auto mt-4">
        <table class="table w-full">
          <thead>
            <tr class="text-gray-100">
              <th>Tool</th>
              <th>Complexity</th>
              <th>Clicks</th>
              <th>Time Spent</th>
              <th>Correctness</th>
            </tr>
          </thead>
          <tbody>
            {#each toolComparison as tool}
              <tr>
                <td>{tool.tool}</td>
                <td>{tool.complexity}</td>
                <td>{tool.clicks}</td>
                <td>{tool.timeSpent}</td>
                <td>{tool.correctness}</td>
              </tr>
            {/each}
          </tbody>
        </table>
      </div>
      
      <div class="mt-4">
        <h2 class="text-lg font-bold">Complexity</h2>
        <p>The complexity of the tool refers to the level of effort and technical knowledge required to use the tool effectively. QVscribe is considered to have a moderate complexity, as the installation and setup process is straightforward, and the tool provides a user-friendly interface for analyzing requirements. On the other hand, SES RAT has a higher complexity, as the process of creating the column mapping and performing the quality assessment involves more steps and requires a deeper understanding of the tool's functionality.</p>
      </div>
      
      <div class="mt-4">
        <h2 class="text-lg font-bold">Clicks</h2>
        <p>The number of clicks represents the total number of user interactions required to complete the task using each tool. QVscribe requires approximately 20 clicks, including the steps for installation, accessing the tool, and performing the analysis. SES RAT requires around 15 clicks, including the steps for opening the Excel file, creating the column mapping, and performing the quality assessment.</p>
      </div>
      
      <div class="mt-4">
        <h2 class="text-lg font-bold">Time Spent</h2>
        <p>The time spent refers to the total duration required to complete the task using each tool. QVscribe takes approximately 16 minutes, while SES RAT takes around 33 minutes and 10 seconds. The longer time spent with SES RAT is due to the more involved process of creating the column mapping and performing the quality assessment.</p>
      </div>
      
      <div class="mt-4">
        <h2 class="text-lg font-bold">Correctness</h2>
        <p>The correctness of the results refers to the quality and accuracy of the output provided by each tool. QVscribe highlights wrong words in the requirements, provides a score summary, and identifies common problems, which can be useful for understanding the quality of the requirements. It also allows users to fix issues directly within the tool. SES RAT, on the other hand, allows creating quality assessment columns in Excel, but the process is more involved and may not provide the same level of detailed feedback as QVscribe.</p>
      </div>
  </div>