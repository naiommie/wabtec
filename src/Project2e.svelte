<div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start mb-4">
        <a href="/project2" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to decision matrix table...</a>
      </div>
      <h2 class="text-2xl font-bold mb-4">Reporting</h2>
      <p class="mb-4">Here is the reporting instructions for both requirements analyzer tools</p>
      <div class="flex justify-between">
        <div class="w-1/2">
            <h2 class="text-2xl font-bold mb-4">QVscribe</h2>
            <p class="mb-4">After the analysis is done, there is two way to generate report</p>
            <ol class="list-decimal pl-6 space-y-2">
                <li>Press Generate report in right low corner
                    <img src="src/assets/Reporting_qvscribe1.png" alt="reporting_qvscribe1" class="-ml-4 my-4">
                </li>
                <ul class="list-disc pl-6 space-y-2">
                    <li>Select all checkboxes (HTML format, Include individual requirements with scores of 1, 2, 3, 4, 5, Include scores, Score Summary, Analysis Breakdown, Unit and Term consistency, Configuration Appendix, Requirement Similarity)</li>
                    <li>Press Create</li>
                
                   <p class="mb-2">Pros:</p>
                    <ul class="list-disc pl-6 space-y-2">
                      <li>All wrong words in the requirements are highlighted in pdf format</li>
                      <li>Provide a Score Summary (why we care? -> we can understand how well the specific requirements written. ex: we have 10 specific requirements for tire size, and a score summary will show is this 10 requirements written good)</li>
                      <li>Provide common problems (why we care? -> we can see common issues like using of passive voice. However, the naming of these problems are too wide)</li>
                      <li>Can select requirements only with bad score, so we can send these requirements for fixing to someone else who is expert in this</li>
                    </ul>
                    <p class="mb-2">Cons:</p>
                    <ul class="list-disc pl-6 space-y-2">
                      <li>We don't care about all wrong words highlighted. It is good only for an overview report. However when it comes to fixing these words, inside the tool we can select a specific requirement, and then it will automatically highlight these wrong words for that requirement.</li>
                      <li>Do we really need Score Summary? It does not perform any useful function</li>
                      <li>Do we really need common problems? It does not perform any useful function</li>
                      <li>PDF format is usually hard to operate</li>
                    </ul>
                </ul>

                <li>Manually copy every requirement in the excel sheet</li>
                <ul class="list-disc pl-6 space-y-2">
                    <li>Paste it to next cell</li>
                    <p class="mb-2">Pros:</p>
                    <ul class="list-disc pl-6 space-y-2">
                      <li>All wrong words in the requirements are highlighted in an excel format</li>
                    </ul>
                    <p class="mb-2">Cons:</p>
                    <ul class="list-disc pl-6 space-y-2">
                        <li>Time complexity is poor</li>
                    </ul>
                </ul>
        </div>
        <div class="w-1/2">
            <h2 class="text-2xl font-bold mb-4">SES RAT</h2>
            <p class="mb-4">After the analysis is done there is only 1 way of generating report</p>
            <ol class="list-decimal pl-6 space-y-2">
                <li>[IMPORTANT] Go to Project Configuration</li>
                <ul class="list-disc pl-6 space-y-2">
                    <li>Double click on appeared worksheets </li>
                    <li>Check Save quality assessment in Microsoft Excel and Uncheck Include requirement title in assessment
                        <img src="src/assets/Reporting_ses1.png" alt="reporting_ses1" class="-ml-4 my-4">
                    </li>
                    <li>Press Ok </li>
                    <li>Go back to Quality Assurance tab</li>
                    <li>On right top, press Save</li>
                    <ul class="list-disc pl-6 space-y-2">
                        <li>A pop up window with The following modules will be saved: - Sheet 1. Do you want to continue?</li>
                        <li>Press Yes</li>
                        <li>Press All changes </li>
                        <li>Press Ok</li>
                    </ul>
                </ul>
                
                
                   <p class="mb-2">Pros:</p>
                    <ul class="list-disc pl-6 space-y-2">
                      <li>All errors, score, and date are highlighted in the same excel</li>
                      <li>Relatively fast (took ~3 more minutes)</li>
                    </ul>
                    <p class="mb-2">Cons:</p>
                    <ul class="list-disc pl-6 space-y-2">
                      <li>Lack of Customization (but I can sort inside the Excel)</li>
                    </ul>
               
        </div>
      </div>

</div>