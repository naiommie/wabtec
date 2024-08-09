<script lang="ts">
    import * as XLSX from 'xlsx';
    let personalAccessToken: string = '';
    let errorMessage: string = '';

    const containers = [
        { projectId: 27085, name: "con_audio_alarms" },
        { projectId: 27458, name: "con_aux_speed_indicator" },
        { projectId: 25761, name: "con_lights_control" },
        { projectId: 27489, name: "con_loco_control_gateway" },
        { projectId: 24701, name: "con_rail_adhesion" },
        { projectId: 26065, name: "con_switchgear_control" },
        { projectId: 15542, name: "con_air_brake_management" },
        { projectId: 15548, name: "con_event_recorder" },
        { projectId: 15546, name: "con_display" },
        { projectId: 30282, name: "con_aux_inverter_control" },
        { projectId: 29027, name: "con_high_voltage_aux_bus" },
        { projectId: 28171, name: "con_axle_powerup" },
        { projectId: 26206, name: "con_energy_storage" },
        { projectId: 26251, name: "con_self_test" },
        { projectId: 15543, name: "con_aux_equipment" },
        { projectId: 15552, name: "con_locomotive_speed" },
        { projectId: 15551, name: "con_locomotive_control" },
        { projectId: 15550, name: "con_high_voltage" },
        { projectId: 15560, name: "con_torque" },
        { projectId: 30393, name: "con_maintenance_charge_control" }
    ];

    const submodules = [
        { id: 14327, subname: "gets-common-scripts" },
        { id: 14348, subname: "gets-matlab-devenv" },
        { id: 14351, subname: "gets-platform" },
        { id: 15606, subname: "lib_apl_environment" },
        { id: 15607, subname: "lib_apl_data_model" },
        { id: 15651, subname: "lib_wabtec_simulink" },
        { id: 15045, subname: "libappbase" },
        { id: 29745, subname: "libddssecure" },
        { id: 15049, subname: "libdispatcher" },
        { id: 15052, subname: "libidlinterfaces" },
        { id: 15071, subname: "libxcp" }
    ];

    let branches: { [key: string]: { name: string }[] } = {};
    let selectedBranches: { [key: string]: string | null } = {};
    let commitData: { [key: string]: { name: string; id: string; lastPipelineRef: string }[] } = {};
    let showTable: boolean = false;
    let isLoading: boolean = false;

    async function getBranches() {
        isLoading = true;
        try {
            for (const container of containers) {
                const response = await fetch(`https://gitlab.corp.wabtec.com/api/v4/projects/${container.projectId}/repository/branches?per_page=100`, {
                    headers: {
                        'PRIVATE-TOKEN': personalAccessToken
                    }
                });
                if (!response.ok) {
                    throw new Error('Invalid personal access token');
                }
                const data = await response.json();
                branches[container.name] = data.map((item: { name: string }) => ({ name: item.name }));
            }
            errorMessage = '';
        } catch (error) {
            errorMessage = 'Invalid personal access token';
        }
        isLoading = false;
    }

    async function getCommitData() {
        isLoading = true;
        for (const container of containers) {
            const selectedBranch = selectedBranches[container.name];
            if (selectedBranch) {
                let page = 1;
                let commitInfo: { name: string; id: string; lastPipelineRef: string }[] = [];
                while (true) {
                    const response = await fetch(`https://gitlab.corp.wabtec.com/api/v4/projects/${container.projectId}/repository/tree?ref=${selectedBranch}&per_page=100&page=${page}`, {
                        headers: {
                            'PRIVATE-TOKEN': personalAccessToken
                        }
                    });
                    const data = await response.json();
                    const filteredData = data.filter((item: { type: string }) => item.type === 'commit');
                    const newCommitInfo = await Promise.all(filteredData.map(async (item: { name: string; id: string }) => {
                        const submoduleMatch = submodules.find(submodule => submodule.subname === item.name);
                        if (submoduleMatch) {
                            const commitResponse = await fetch(`https://gitlab.corp.wabtec.com/api/v4/projects/${submoduleMatch.id}/repository/commits/${item.id}?per_page=100`, {
                                headers: {
                                    'PRIVATE-TOKEN': personalAccessToken
                                }
                            });
                            const commitData = await commitResponse.json();
                            return { name: item.name, id: item.id, lastPipelineRef: commitData.last_pipeline?.ref || 'N/A' };
                        }
                        return null;
                    }));
                    commitInfo = [...commitInfo, ...newCommitInfo.filter(item => item !== null)];
                    if (data.length < 100) {
                        break;
                    }
                    page++;
                }
                commitData[`${container.name}-${selectedBranch}`] = commitInfo;
            }
        }
        showTable = true;
        isLoading = false;
    }

    function handleRefresh() {
        getBranches();
        showTable = true;
    }

    function handleRunCommitData() {
        getCommitData();
    }

    function exportToExcel() {
        const workbook = XLSX.utils.book_new();
        const worksheet = XLSX.utils.json_to_sheet([]);

        // Add submodule names to the first row
        XLSX.utils.sheet_add_aoa(worksheet, [['', ...submodules.map(submodule => submodule.subname)]], { origin: 'A1' });

        // Add container and commit data to the worksheet
        let rowIndex = 1;
        for (const [containerName, selectedBranch] of Object.entries(selectedBranches)) {
            if (selectedBranch) {
                const commitInfos = commitData[`${containerName}-${selectedBranch}`] || [];
                const data = [[containerName, ...commitInfos.map(info => info?.lastPipelineRef || 'N/A')]];
                XLSX.utils.sheet_add_aoa(worksheet, data, { origin: `A${rowIndex + 1}` });
                rowIndex += 1;
            }
        }

        XLSX.utils.book_append_sheet(workbook, worksheet, 'Submodule Tags');
        XLSX.writeFile(workbook, 'submodule-tags.xlsx');
    }

    function exportToJSON() {
        const jsonContent = JSON.stringify(commitData, null, 2);
        const blob = new Blob([jsonContent], { type: 'application/json;charset=utf-8;' });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.setAttribute('href', url);
        link.setAttribute('download', 'submodule-tags.json');
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }

    function exportToCSV() {
        const worksheet = XLSX.utils.json_to_sheet([]);

        // Add submodule names to the first row
        XLSX.utils.sheet_add_aoa(worksheet, [['', ...submodules.map(submodule => submodule.subname)]], { origin: 'A1' });

        // Add container and commit data to the worksheet
        let rowIndex = 1;
        for (const [containerName, selectedBranch] of Object.entries(selectedBranches)) {
            if (selectedBranch) {
                const commitInfos = commitData[`${containerName}-${selectedBranch}`] || [];
                const data = [[containerName, ...commitInfos.map(info => info?.lastPipelineRef || 'N/A')]];
                XLSX.utils.sheet_add_aoa(worksheet, data, { origin: `A${rowIndex + 1}` });
                rowIndex += 1;
            }
        }

        const csvContent = XLSX.utils.sheet_to_csv(worksheet);
        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.setAttribute('href', url);
        link.setAttribute('download', 'submodule-tags.csv');
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }

</script>

<div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start">
        <a href="/projects" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to project list...</a>
    </div>
    <h1 class="text-2xl font-bold my-4">Retrieving submodule tags from gitlab project using API</h1>
    <h2 class="mb-6">This project retrieves submodule tags from a Wabtec Gitlab project using the Gitlab API. 
        The specific branch for each container should be <span class="font-bold text-blue-500">manually</span> selected in order to retrieve their submodule tags.
        <br>If you want to proceed with <span class="font-bold text-blue-500">auto-selection version</span>, please visit this 
        <a href="/project4" class="underline hover:bg-[rgba(0,0,0,0.2)]">page.</a>
        The process of the code can be find 
        <a href="/project5" class="underline hover:bg-[rgba(0,0,0,0.2)]">here.</a> 
        
    </h2>
    <p class="text-2xl text-center font-bold mb-8"> Try the code </p>
    <input type="password" bind:value={personalAccessToken} placeholder="Enter your personal access token" class="bg-[rgba(0,0,0,0.35)] w-1/6 rounded-lg p-2 mb-4" />
    {#if errorMessage}
        <div class="bg-red-500 text-white p-2 mb-4">{errorMessage}</div>
    {/if}
    <button on:click={handleRefresh} class="bg-green-700 hover:bg-green-500 font-bold py-2 px-4 rounded mb-4 {isLoading ? 'opacity-50 cursor-not-allowed' : ''}">
        {#if isLoading}
            <div class="animate-spin rounded-full h-5 w-5 border-t-2 border-b-2 border-white"></div>
        {:else}
            Refresh
        {/if}
    </button>

    <div class="grid grid-cols-4 gap-4 m-4">
        {#each containers as container}
            <div>
                <div class="block mb-2">{container.name}</div>
                <select bind:value={selectedBranches[container.name]} class="text-black rounded-lg p-2 w-full">
                    <option value={null}>Select a branch</option>
                    {#each branches[container.name] || [] as branch}
                        <option value={branch.name}>{branch.name}</option>
                    {/each}
                </select>
            </div>
        {/each}
    </div>

    <button on:click={handleRunCommitData} class="bg-green-700 hover:bg-green-500 text-white font-bold py-2 px-4 mt-4 rounded {isLoading ? 'opacity-50 cursor-not-allowed' : ''}">
        {#if isLoading}
            <div class="animate-spin rounded-full h-5 w-5 border-t-2 border-b-2 mt-4 border-white"></div>
        {:else}
            Press to Run
        {/if}
    </button>

    {#if showTable}
        <div class="overflow-x-auto">
            <table class="w-full mt-8 text-xs">
                <tr>
                    <th class="p-2"></th>
                    {#each submodules as submodule}
                        <th class="p-2 table-auto">{submodule.subname}</th>
                    {/each}
                </tr>
                {#each containers as container}
                    {#if selectedBranches[container.name]}
                        <tr>
                            <td class="p-2">{container.name}</td>
                            {#each commitData[`${container.name}-${selectedBranches[container.name]}`] || [] as commitInfo}
                                <td class="p-2">{commitInfo?.lastPipelineRef || 'N/A'}</td>
                            {/each}
                        </tr>
                    {/if}
                {/each}
            </table>
        </div>
        <button on:click={exportToExcel} class="bg-green-700 hover:bg-green-500 text-white font-bold py-2 px-4 mt-4 rounded">
            Export to Excel (xlsx)
        </button>
        <button on:click={exportToJSON} class="bg-green-700 hover:bg-green-500 text-white font-bold py-2 px-4 mt-4 rounded">
            Export raw data with commitSHA and tags to JSON
        </button>
        <button on:click={exportToCSV} class="bg-green-700 hover:bg-green-500 text-white font-bold py-2 px-4 mt-4 rounded">
            Export to CSV
        </button>

        
    {/if}

</div>