<script>

  </script>
  

  <div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start">
        <a href="/projects" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to project list...</a>
    </div>
    <h1 class="text-2xl font-bold mt-4 mb-4">Troubleshooting</h1>

    <div class="collapse bg-[rgba(0,0,0,0.5)] m-4 -ml-1 text-gray-100">
        <input type="checkbox" />
            <div class="collapse-title text-xl font-medium">
                Issues with SES RAT API web browser extension
            </div>
            <div class="collapse-content">
                <p> Adding port 9000 (SES RAT API works on localhost:9000). To see full instruction, please visit this
                    <a href="https://wabtec-my.sharepoint.com/:w:/p/sanzhar_shakarim/EWlOBBpYGDRAuOBux1AWDw4BxVa-O-Vr0GSdIcJfD_v9Rw?e=P52bdo" class="underline hover:bg-[rgba(0,0,0,0.2)]"> page. </a>
                </p>
                <h3 class="ml-2 pt-2">Solution:</h3>
                <p class="ml-4"> 1. Go to windows Defender Firewall </p>
                <p class="ml-4"> 2. Advanced settings </p>
                <p class="ml-4"> 3. Press Inbound Rules </p>
                <p class="ml-4"> 4. New rule </p>
                <p class="ml-4"> 5. Port  </p>
                <p class="ml-4"> 6. TCP and Specific Local Ports: Enter 9000 </p>
                
                <h2 class="mt-4">HTTP Error 500.32 - Failed to load .NET Core host</h2>
                <p>The app was likely published for a different bitness than w3wp.exe/iisexpress.exe is running as.</p>
                <h3 class="ml-2 pt-2">Solution:</h3>
                <div class="ml-4">
                    <li>Go to Internet Information Services (IIS) Manager</li>
                    <li>Navigate to Application Pools</li>
                    <li>Select the application pool in the Name column (e.g., 10.85.206.28)</li>
                    <li>On the right, click on "Advanced Settings..."</li>
                    <li>In the Advanced Settings dialog, find the "Enable 32-Bit Applications" setting and set it to "False"</li>
                </div>

                <h2 class="mt-4">HTTP Error 500.31 - Failed to load ASP.NET Core runtime</h2>
                <p>The specified version of Microsoft.NetCore.App or Microsoft.AspNetCore.App was not found.</p>
                <h3 class="ml-2 pt-2">Solution:</h3>
                <div class="ml-4">
                    <li>Go to the JSON file, search for the .NET Core app version, and install it from the Microsoft dotnet website.</li>
                    <li>Go to the Event Viewer, navigate to Windows Logs -> Application, find the last error, double-click it, and look for details.</li>
                </div>
            </div>
    </div>
    
    <div class="collapse bg-[rgba(0,0,0,0.5)] m-4 -ml-1 text-gray-100">
        <input type="checkbox" />
            <div class="collapse-title text-xl font-medium">
                Issues with SES RAT plugin for MS Excel 
            </div>
            <div class="collapse-content">
                This problem occur only with remote machine, since they have microsoft website restrictions.
                <h3 class="ml-2 pt-2">Solution:</h3>
                <div class="ml-4">
                    1. When you log in Excel
                    <br> 2. Go to Internet Options Security 
                    <br> 3. Trusted Sites 
                    <br> 4. Sites
                    <br> 5. Enter oca.microsoft.com 
                    <br> 6. Add
                </div>
                 
                
                  
            </div>
    </div>

    <div class="collapse bg-[rgba(0,0,0,0.5)] m-4 -ml-1 text-gray-100">
        <input type="checkbox" />
            <div class="collapse-title text-xl font-medium">
                Issues with QVscribe plugin for MS Excel add-in
            </div>
            <div class="collapse-content">
                <table>
                    <td>
                        Sometime Excel just shut down, and this appear:
                        <img src="src/assets/qvscribe_issue1.png" alt="qvscribe_issue1" class="p-4">    
                    </td>
                    <td>
                        Or when you change the text in the cell by suddenly pressing any key, the excel will not respond and shut down:
                        <img src="src/assets/qvscribe_issue01.png" alt="qvscribe_issue01" class="p-4">
                    </td>
                    
                </table>
                
                
                Reopening Excel or pressing yes leads to this window:
                <img src="src/assets/qvscribe_issue2.png" alt="qvscribe_issue2" class="p-4">
                
                <h3 class="ml-2 pt-2">Solution:</h3>
                <div class="ml-4">
                    1. Reopen Excel and proceed with following steps every time when you see something like this
                    <table>
                        <tbody>
                            <td>
                                <img src="src/assets/qvscribe_issue3.png" alt="qvscribe_issue3" class="p-4"> 
                            </td>
                            <td>
                                <img src="src/assets/qvscribe_issue4.png" alt="qvscribe_issue4" class="p-4"> 
                            </td>
                            <td>
                                <img src="src/assets/qvscribe_issue0.png" alt="qvscribe_issue0" class="h-4/5 p-4"> 
                            </td>
                        </tbody>
                        <tbody>
                            <td>
                                <img src="src/assets/qvscribe_issue6.png" alt="qvscribe_issue6" class="p-4"> 
                            </td>
                            <td>
                                <img src="src/assets/qvscribe_issue7.png" alt="qvscribe_issue7" class="p-4"> 
                            </td>
                            <td>
                                <img src="src/assets/qvscribe_issue5.png" alt="qvscribe_issue5" class="p-4">
                            </td>
                        </tbody>
                        
                        
                    </table>
                        
                        
                         
                        
                        
                    2. Double click on that "damaged" cell
                    <img src="src/assets/qvscribe_issue8.png" alt="qvscribe_issue8" class="p-4"> 
                    3. Cut text inside the cell
                    <br> 4. Paste it in the same cell  
                    <br> 5. Here is before/after result:
                    <img src="src/assets/qvscribe_issue9.png" alt="qvscribe_issue9" class="p-4">
                </div>
            </div>
    </div>

    

  </div>