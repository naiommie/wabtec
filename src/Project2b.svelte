<div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start mb-4">
        <a href="/project2" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to decision matrix table...</a>
      </div>
    <h2 class="text-2xl font-bold mb-4">UI/UX</h2>
    <p class="mb-4">Here is the step by step instruction of how to analyze requirements using these tools</p>
<div class="flex justify-between">
    <div class="w-2/5">
      <h2 class="text-2xl font-bold mb-4">QVscribe</h2>
      <ol class="list-decimal pl-6 space-y-2">
        <li>Open excel file</li>
        <li>Press QVscribe</li>
        <ul class="list-disc pl-6 space-y-2">
          <li>In pop up window enter: poc-qvscribe.wabtec.com</li>
          <li>Press Connect to your Server</li>
          <li>Put poc-qvscribe.wabtec.com</li>
          <li>Select local</li>
          <li>Insert your username and password (QVscribe@123)</li>
        </ul>
        <li>In opened QVScribe window press ID Column and select column B (Name) which should be name of the requirements</li>
        <li>Select all requirements</li>
        <li>Press Mark Requirements</li>
        <li>Press Start Analyzing</li>
        <li>Press View Analysis</li>
        <ul class="list-disc pl-6 space-y-2">
          <li>Generating Report Steps:</li>
          <ul class="list-disc pl-6 space-y-2">
            <li>Press Generate Report</li>
            <li>Select all checkboxes (HTML format, Include individual requirements with scores of 1, 2, 3, 4, 5, Include scores, Score Summary, Analysis Breakdown, Unit and Term consistency, Configuration Appendix, Requirement Similarity)</li>
            <li>Press Create</li>
          </ul>
          <li>Pros:</li>
          <ul class="list-disc pl-6 space-y-2">
            <li>All wrong words in the requirements are highlighted.</li>
            <li>Provide a Score Summary (why we care? -> we can understand how well the specific requirements written. ex: we have 10 specific requirements for tire size, and a score summary will show is this 10 requirements written good)</li>
            <li>Provide common problems (why we care? -> we can see common issues like using of passive voice. However, the naming of these problems are too wide)</li>
            <li>Can select requirements only with bad score, so we can send these requirements for fixing to someone else who is expert in this.</li>
          </ul>
          <li>Cons:</li>
          <ul class="list-disc pl-6 space-y-2">
            <li>We don't care about all wrong words highlighted. It is good only for an overview report. However when it comes to fixing these words, inside the tool we can select a specific requirement, and then it will automatically highlight these wrong words for that requirement.</li>
            <li>Do we really need Score Summary? It does not perform any useful function</li>
            <li>Do we really need common problems? It does not perform any useful function</li>
          </ul>
        </ul>
        <li>Fixing problems:</li>
        <ul class="list-disc pl-6 space-y-2">
          <li>In Excel select requirement and the wrong words will appear -> change the wrong word right now -> press Reanalyze Selected -> pop up window will appear -> check Don't show this message again -> press Yes</li>
          <li>Pros: Inside the requirement can see Recommendation, Incorrect Example, and Correct Example. Therefore, it will be easier to understand the issue.</li>
        </ul>
        <li>Time spend (Total: ~16 minutes):</li>
        <ul class="list-disc pl-6 space-y-2">
          <li>To Mark Requirements (20520 requirements): ~3 minutes</li>
          <li>To Analyze 20520 Requirements: Quality ~ 1 minute 53 seconds, Consistency ~ 1 minutes 55 seconds, Similarity ~ 5 minutes 50 seconds</li>
          <li>To View Analysis: ~ 1 minute 40 seconds</li>
          <li>To Generate Report: ~ 1 minute 43 seconds</li>
        </ul>
      </ol>
    </div>
    <div class="w-1/2 ">
      <h2 class="text-2xl font-bold mb-4">SES RAT</h2>
      <ol class="list-decimal pl-6 space-y-2">
        <li>Open excel file</li>
        <li>Create new column with name Author, Creation date and Modification date</li>
        <li>Fill all Author column with any name, all Creation and Modification date columns with any date (type "=Today()")</li>
        <li>Save the file</li>
        <li>Open SES Engineering Studio</li>
        <li>Login to SES</li>
        <li>Press Add Connection</li>
        <ul class="list-disc pl-6 space-y-2">
          <li>In a pop up window select Microsoft Excel Requirements</li>
          <li>Press Ok</li>
          <li>In Configuration window in Search Directory locate the folder with an excel file containing requirements (The excel files inside the selected folder will not be shown)</li>
          <li>Press Select Folder</li>
          <li>Now you will see excel files but they are not pressable</li>
          <li>Right click on the excel file you are intending to work</li>
          <li>Select Create column mapping</li>
          <li>In Code select column with numbers (#), in Title/Heading select column with the requirements name (Name), in Description/Statement select column with requirements, in Author select author column that we created, in Creation date select creation date column that we created, in Modification date select modification date column that we created</li>
          <li>Press Next</li>
          <li>In new window, don't touch anything and press Next</li>
          <li>In new window, check Enable saving quality information in Excel:</li>
          <ul class="list-disc pl-6 space-y-2">
            <li>Mark:</li>
            <ul class="list-disc pl-6 space-y-2">
              <li>Create a new quality level column</li>
              <li>Create a new numeric quality level column</li>
              <li>Create a new quality summary column</li>
              <li>Create a new quality date column</li>
            </ul>
          </ul>
          <li>Press Next</li>
          <li>In new window, don't touch anything and press Next:</li>
          <li>Press Create</li>
          <li>Mark the excel file with requirements and press OK</li>
          <li>In Information window in Connection Information in Name write the name for this connection (good practice to write description of excel file)</li>
          <li>Check Shared connection</li>
          <li>Press Ok</li>
        </ul>
        <li>In Connections you will see your newly created connection with name you wrote.</li>
        <ul class="list-disc pl-6 space-y-2">
          <li>Double click on it</li>
          <li>Press Views </li>
          <li>Select QUALITY</li>
          <li>Pop up window with: The worksheet 'Sheet 1' has no metrics defined to access quality. Do you want to link a metrics template to this worksheet? If you do not choose a metrics template, no quality assessment will be performed.</li>
          <li>Press Yes</li>
          <li>In new window, Metrics set templates: 1 will appear. Don't touch anything and press OK</li>
        </ul>
        <li>[IMPORTANT] Go to Project Configuration</li>
        <ul class="list-disc pl-6 space-y-2">
          <li>Double click on appeared worksheets </li>
          <li>Check Save quality assessment in Microsoft Excel and Uncheck Include requirement title in assessment</li>
          <li>Press Ok </li>
          <li>Go back to Quality Assurance tab</li>
          <li>On right top, press Save</li>
          <ul class="list-disc pl-6 space-y-2">
            <li>A pop up window with The following modules will be saved: - Sheet 1. Do you want to continue?</li>
            <li>Press Yes</li>
            <li>Press All changes </li>
            <li>Press Ok</li>
          </ul>
          <li>In left bottom, choose Assess Quality, select Assess Correctness for the whole Specification</li>
          <ul class="list-disc pl-6 space-y-2">
            <li>A pop up window with: This process can take several minutes. Do you want to assess the quality for all requirements?</li>
            <li>Press Yes</li>
            <li>Pop up window with: The process finished successfully will appear. Press Ok</li>
          </ul>
          <li>Press Save</li>
        </ul>
        <li>Time spend (Total: ~ 22 minutes):</li>
        <ul class="list-disc pl-6 space-y-2">
            <li>Add connection (from the openning SES Engineering Studio until the CONTENT window appears)~ 1 min</li>
            <li>Making it saveable to excel (configurate inside a project configuration tab) ~ 30 seconds </li>
            <li>Saving it after step 2 ~ 15 seconds </li>
            <li>Assessing correctness for requirement ~ 18 min 39 seconds </li>
            <li>Saving it after step 4 ~ 50 seconds </li>
          </ul>
      </ol>
    </div>
  </div>
</div>