<script lang="ts">
    interface Branch {
        name: string;
        commit: {
            id: string;
            created_at: string;
        };
        protected: boolean;
        default: boolean;
        merged: boolean;
        developers_can_push: boolean;
        developers_can_merge: boolean;
    }
  
    interface Commit {
        name: string;
        id: string;
        projectId: number;
        title: string;
    }
  
    interface Container {
        projectId: number;
        name: string;
    }
  
    interface CommitInfo {
        id: number;
        name: string;
    }
  
    const containers: Container[] = [
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
  
    let selectedContainers: Container[] = [];
    let branches: Branch[] = [];
    let selectedBranch = '';
    let commits: Commit[] = [];
    let accessToken = 'wabtknYMXyxq8_hNzED7xmZ8Zh';
    let selectAllContainers = false;
    let lastPipelineRefs: string[] = [];
    let commitDetails: { commitName: string; lastPipelineRef: string }[] = [];
    
    async function fetchBranches(projectId: number) {
        try {
            const response = await fetch(`https://gitlab.corp.wabtec.com/api/v4/projects/${projectId}/repository/branches?per_page=100`, {
                headers: {
                    'Authorization': `Bearer ${accessToken}`
                }
            });
            branches = await response.json();
        } catch (error) {
            console.error('Error fetching branches:', error);
        }
    }
  
    async function fetchCommits(projectId: number, selectedBranch: string) {
        try {
            const response = await fetch(`https://gitlab.corp.wabtec.com/api/v4/projects/${projectId}/repository/tree?ref=${selectedBranch}&per_page=100`, {
                headers: {
                    'Authorization': `Bearer ${accessToken}`
                }
            });
            const data = await response.json();
            console.log('Commit API response:', data);
  
            // Map the commit data to the Commit interface
            commits = await Promise.all(
                data.filter((item: any) => item.type === 'commit').map(async (item: any) => ({
                    name: item.name,
                    id: item.id,
                    projectId: projectId,
                    title: ''
                }))
            );
  
            // Fetch the commit details for each commit
            lastPipelineRefs = await Promise.all(
                commits.map(async (commit) => await fetchCommitDetails(commit))
            );
        } catch (error) {
            console.error('Error fetching commits:', error);
        }
    }
  
    const commitInfo: CommitInfo[] = [
        { id: 14327, name: "gets-common-scripts" },
        { id: 14348, name: "gets-matlab-devenv" },
        { id: 14351, name: "gets-platform" },
        { id: 15606, name: "lib_apl_environment" },
        { id: 15607, name: "lib_apl_data_model" },
        { id: 15651, name: "lib_wabtec_simulink" },
        { id: 15045, name: "libappbase" },
        { id: 29745, name: "libddssecure" },
        { id: 15049, name: "libdispatcher" },
        { id: 15052, name: "libidlinterfaces" },
        { id: 15071, name: "libxcp" }
    ];
  
    async function fetchCommitDetails(commit: Commit): Promise<string> {
        try {
            const commitInfoItem = commitInfo.find((info: CommitInfo) => info.name === commit.name);
            if (commitInfoItem) {
                const response = await fetch(`https://gitlab.corp.wabtec.com/api/v4/projects/${commitInfoItem.id}/repository/commits/${commit.id}`, {
                    headers: {
                        'Authorization': `Bearer ${accessToken}`
                    }
                });
                const data = await response.json();
                console.log('Commit Details API response:', data.title);
                return data.title || '';
            } else {
                return '';
            }
        } catch (error) {
            console.error('Error fetching commit details:', error);
            return '';
        }
    }
  
    let isLoading = false;
  
    async function fetchAndDisplayCommitDetails() {
    isLoading = true;
    if (selectedContainers.length > 0 && selectedBranch) {
        try {
            const projectId = selectedContainers[0].projectId;
            let page = 1;
            let hasMorePages = true;
            let allCommitDetails: { commitName: string; lastPipelineRef: string }[] = [];
  
            while (hasMorePages) {
                const response = await fetch(`https://gitlab.corp.wabtec.com/api/v4/projects/${projectId}/repository/tree?ref=${selectedBranch}&per_page=100&page=${page}`, {
                    headers: {
                        'Authorization': `Bearer ${accessToken}`
                    }
                });
                const data = await response.json();
  
                const pageCommitDetails = await Promise.all(
                    data.filter((item: any) => item.type === 'commit').map(async (item: any) => {
                        const commit: Commit = {
                            name: item.name,
                            id: item.id,
                            projectId: projectId,
                            title: ''
                        };
                        const lastPipelineRef = await fetchCommitDetails(commit);
                        return { commitName: commit.name, lastPipelineRef };
                    })
                );
  
                allCommitDetails = [...allCommitDetails, ...pageCommitDetails];
  
                // Check if there are more pages
                const linkHeader = response.headers.get('Link');
                hasMorePages = linkHeader !== null && linkHeader.includes('rel="next"');
                page++;
            }
  
            commitDetails = allCommitDetails;
        } catch (error) {
            console.error('Error fetching commit details:', error);
        } finally {
            isLoading = false;
        }
    } else {
        isLoading = false;
    }
  }
  
    function handleContainerSelection() {
        if (selectAllContainers) {
            selectedContainers = containers;
        } else {
            selectedContainers = containers.filter((container) => (document.querySelector(`#container-${container.projectId}`) as HTMLInputElement)?.checked);
            if (selectedContainers.length === 1) {
                // Disable all other containers
                containers.forEach((container) => {
                    if (container.projectId !== selectedContainers[0].projectId) {
                        (document.querySelector(`#container-${container.projectId}`) as HTMLInputElement).disabled = true;
                    }
                });
            } else {
                // Enable all containers
                containers.forEach((container) => {
                    (document.querySelector(`#container-${container.projectId}`) as HTMLInputElement).disabled = false;
                });
            }
        }
  
        if (selectedContainers.length > 0) {
            fetchBranches(selectedContainers[0].projectId);
        }
    }
  
    function handleBranchSelection() {
        if (selectedContainers.length > 0) {
            fetchCommits(selectedContainers[0].projectId, selectedBranch);
        }
    }
  </script>
  
  <div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start">
        <a href="/projects" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to project list...</a>
    </div>
  
    <h1 class="text-2xl font-bold mt-4 mb-4">Retrieving submodule tags from gitlab project using API</h1>
    
     
    <div class="collapse bg-[rgba(0,0,0,0.5)] m-4 -ml-1 text-gray-100">
        <input type="checkbox" />
            <div class="collapse-title text-xl font-medium">
                Code description
            </div>
                <div class="collapse-content">
                    <p class="mb-2">This project retrieves submodule tags from a Wabtec Gitlab project using the Gitlab API. The process is as follows:</p>
                    <p class="mb-2 ml-4">1. Match the user-selected container with its corresponding project ID.</p>
                    <p class="mb-2 ml-8">1. 1. Pass the container project ID value to a first API call.</p>
                    <p class="mb-2 ml-4">2. Make a first API call to retrieve all branch names for the specified container.</p>
                    <p class="mb-2 ml-8">2. 1. Pass the user-selected branch name to a second API call.</p>
                    <p class="mb-2 ml-4">3. Make a second API call to retrieve the submodule name and commit SHA.</p>
                    <p class="mb-2 ml-4">4. Match retrieved submodule name with its corresponding project ID.</p>
                    <p class="mb-2 ml-8">4. 1. Pass the submodule project ID value to a third API call.</p>
                    <p class="mb-2 ml-4">5. Make a third API call to retrieve the tags for each submodule by matching the commit SHA from second API call.</p>
                </div>
    </div>
 

    <div class="collapse bg-[rgba(0,0,0,0.5)] m-4 -ml-1 text-gray-100">
        <input type="checkbox" />
            <div class="collapse-title text-xl font-medium">
                Try the code
            </div>
                <div class="collapse-content">
                    To see submodule tags, please select the container, its branch and press button
                    <div class="flex items-center mt-4 mb-4">
                        <input type="checkbox" id="select-all" bind:checked={selectAllContainers} class="checkbox checkbox-info mr-2" />
                        <label for="select-all" class="ml-2">Select All (not working)</label>
                    </div>
                    <div class="grid grid-cols-3 gap-4">
                        {#each containers as container}
                            <div class="flex items-center text-sm">
                                <input type="checkbox" id="container-{container.projectId}" on:change={handleContainerSelection} class="checkbox checkbox-success checkbox-md mr-2" />
                                <label for="container-{container.projectId}" class="ml-2">{container.name}</label>
                            </div>
                        {/each}
                    </div>
                  
                    <h2 class="text-lg mt-8 mb-4">Choose the container branch:</h2>
                    <select class="select select-bordered w-full max-w-xs text-base text-black" bind:value={selectedBranch} on:change={handleBranchSelection}>
                        <option disabled selected>Select a branch</option>
                        {#each branches as branch}
                            <option value={branch.name}>{branch.name}</option>
                        {/each}
                    </select>
                  
                    <div class="flex justify-center mt-8">
                        <button class="btn btn-success" on:click={fetchAndDisplayCommitDetails}>
                            {#if isLoading}
                                <div class="animate-spin h-5 w-5 mr-3 border-t-2 border-b-2 border-white rounded-full"></div>
                            {/if}
                            Press to Run
                        </button>
                    </div>
                  
                  
                    <h2 class="text-lg mt-8">
                        {#if selectedContainers.length > 0 && selectedBranch}
                            The {selectedContainers[0].name} of {selectedBranch} contains:
                            <div class="overflow-x-auto">
                                <table class="table table-compact w-full">
                                    <thead>
                                        <tr>
                                            <th class="text-white">Submodule Name</th>
                                            <th class="text-white">Submodule Tags</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {#each commitDetails as detail}
                                            <tr>
                                                <td class="text-white">{detail.commitName}</td>
                                                <td class="text-white">{detail.lastPipelineRef}</td>
                                            </tr>
                                        {/each}
                                    </tbody>
                                </table>
                            </div>
                        <!-- {:else}
                             -->
                        {/if}
                    </h2>
                  
                </div>
    </div>    
  </div>
  