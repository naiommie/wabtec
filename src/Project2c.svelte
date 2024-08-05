<div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start mb-4">
        <a href="/project2" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to decision matrix table...</a>
      </div>
    <h2 class="text-2xl font-bold mb-4">OneBot scoring for these set of requirements</h2>
<div class="flex justify-center">
    <table class="w-full border-collapse">
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          The control system shall calculate  Thp_degraded by multiplying max_axle_thp with the available active axles as indicated below:
          Thp_degraded = Max_axle_thp* MIN (NUM_POWERED_AXLES, Number of Active Axles + Number of PEB Axles)
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          480V Bus control shall output FPM Phase A Volt High With All Phase Modules Off flag
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          480V Bus control shall output FPM (Cam Isr Not Running) flag
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          480V Bus control shall output BTMC Cycling While Normal Mode flag
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          The control system shall display a message to the operator (defined for incidents 08-5012 in 84A200750IF) when Event Resets caused by the Alerter reset switch input are detected to be continuous (out of their normal frequency).
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          An operator db match/exceed condition is met when the Operator moves the MC DB Handle to match or exceed the last VALID LCCM DB command if LCCM and Locomotive operating mode was Dynamic Braking prior to "vcsLccmLivelinessLost" is set to "TRUE".
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          Control System shall transition from Brake to Brake Cleanup if any of the following conditions are satisfied:
          <li> Direction call is NEUTRAL or changed </li>
          <li>Brake handle is moved to OFF</li>
          <li>EC Switch NOT in RUN </li>
          <li> Barrier Bar OPEN</li>
            <li> Local Control Circuit Breaker OFF</li>
                <li> PC Trainline Voltage  LESS THAN 30V</li>
                    <li> Aux/Alt sys running is FALSE</li>
                        <li> Dynamic Brake Restriction</li>
                            <li> All Powered Modes Restriction</li>
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">87.5</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          Control system shall have the anti-rolloff feature disabled. As a result, the control system shall have a first reset time equal to the Alerter Reset Time.
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">87.5</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          EQV Control System shall keep EB6 and EB7 OFF atleast for EB6_EB7_OFF_Time.EQV Control System shall keep EB6 and EB7 OFF atleast for EB6_EB7_OFF_Time.
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          This function confirms the operation of each component induvidually.
          This covers Self Test for EB1 to EB5, CBR Relay.
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">50</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          After compressor X is started, control shall ensure that compressor X is continue to run for 5 seconds before shutdown.
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">25</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          Control System shall transition from Ready P to the Brake Setup Configure state when requested through the brake handle and if all the following conditions are TRUE:
          <li>No Dynamic Brake Restriction </li>    
            <li> No All Powered Modes Restriction</li>
                <li> EC Switch in RUN</li>
                    <li> Forward or Reverse Direction Call</li>
                        <li> PC Trainline Voltage GREATER THAN 35V</li>
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          480V Aux Bus Step Load Manager shall Command BTMU Run Perm to TRUE whenever ALL of the following conditions are satisfied(Refer to T7 Transition)
          <li> BTMU Run Request to run</li>
            <li>  BTMU Run perm is not already TRUE</li>
                <li> CDCx Request  is FALSE OR AC X Run Permission is already TRUE</li>
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          The control system  shall apply an lower limit of zero to slew limited net torque limit per axle.
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">50</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          The Local DB Call function shall calculate and set the "local_db_call" using the LCCM command, "emTlDBCallCommand" when all of the following conditions are met:
  
          <li>  Energy Management is in Auto ModeValid or in Direct Control ModeValid</li>
            <li> Energy Management is NOT fully controlling local and trainline dynamic brake</li>
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">100</td>
      </tr>
      <tr>
        <td class="border border-gray-400 p-4 w-3/4">
          The control system shall initiate FPM VI Test in MC Charging when ALL of the below T200 transition conditions are true:
          <li> battery bank 6 for that axle is not restricted</li>
            <li> FPM inverter is not restricted</li>
                <li> DC link[n] voltage on axle[6] is less than 20V (PWRUP_VI_TEST_LINK_VOLTS_THD)</li>
                    <li>  FPM configured as Active Rectifier by TMC traction inverter controller has requested for FPM Inverter VI test OR control system needs to run FPM Inverter VI test</li>
                            <li>  battery bank 6 for that axle is not restricted </li>
                                <li>  FPM inverter is not restricted </li>
                                    <li>  DC link[n] voltage on axle[6] is less than 20V (PWRUP_VI_TEST_LINK_VOLTS_THD)</li>
                                        <li>  FPM configured as Active Rectifier by TMC traction inverter controller has requested for FPM Inverter VI test OR control system needs to run FPM Inverter VI test• Active Rectifier VI Test Count =3</li>
                                            <li>  Charge Aux DC Link with MC = TRUE• Charge Aux DC Link with MC = TRUE </li>
        </td>
        <td class="border border-gray-400 p-4 w-1/4 text-center">75</td>
      </tr>
    </table>
  </div>
</div>