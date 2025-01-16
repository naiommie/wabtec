<script>
  import { Router, Route } from 'svelte-routing';
  import CV from './CV.svelte';
  import Home from './Home.svelte';
  import Projects from './Projects.svelte';
  import Project1 from './Project1.svelte';
  import Project2 from './Project2.svelte';
  import Project2a from './Project2a.svelte';
  import Project2b from './Project2b.svelte';
  import Project2c from './Project2c.svelte';
  import Project2d from './Project2d.svelte';
  import Project2e from './Project2e.svelte';
  import Project2j from './Project2j.svelte';
  import Project3 from './Project3.svelte';
  import Project4 from './Project4.svelte';
  import Project5 from './Project5.svelte';
  import Project6 from './Project6.svelte';
  import Project6a from './Project6a.svelte';
  import Project6a_master from './Project6a_coverage_master.svelte';
  import Project6a_develop from './Project6a_coverage_develop.svelte';
  import Project6a_rhi from './Project6a_coverage_latest.svelte';
  import Project7 from './Project7.svelte';
</script>

<Router>
<div class="background-container">  
  <header>
    <nav>
      <ul>
        <a href="/" class="bg-[rgba(0,0,0,0.35)] m-3.5 text-gray-100 inline-block px-4 py-2 rounded-lg hover:bg-[rgba(0,0,0,0.7)] active:bg-[rgba(0,0,0,0.7)] transition-colors duration-200">
          Sanzhar Shakarim
        </a>
        
        <a href="/cv" class="bg-[rgba(0,0,0,0.35)] float-right m-3.5 text-gray-100 inline-block px-4 py-2 rounded-lg hover:bg-[rgba(0,0,0,0.7)] active:bg-[rgba(0,0,0,0.7)] transition-colors duration-200">
          CV
        </a>

        <a href="/projects" class="bg-[rgba(0,0,0,0.35)] float-right m-3.5 text-gray-100 inline-block px-4 py-2 rounded-lg hover:bg-[rgba(0,0,0,0.7)] active:bg-[rgba(0,0,0,0.7)] transition-colors duration-200">
          Projects
        </a>
        
      </ul>
    </nav>
  </header>


  <main>
    
      <Route path="/wabtec" component={Home} />
      <Route path="/cv" component={CV} />
      <Route path="/wabtec/projects" component={Projects} />
      <Route path="/project1" component={Project1} />
      <Route path="/project2" component={Project2} />
      <Route path="/project2a" component={Project2a} />
      <Route path="/project2b" component={Project2b} />
      <Route path="/project2c" component={Project2c} />
      <Route path="/project2d" component={Project2d} />
      <Route path="/project2e" component={Project2e} />
      <Route path="/project2j" component={Project2j} />
      <Route path="/project3" component={Project3} />
      <Route path="/project4" component={Project4} />
      <Route path="/project5" component={Project5} />
      <Route path="/project6" component={Project6} />
      <Route path="/project6a" component={Project6a} />
      <Route path="/project6a_coverage_master" component={Project6a_master} />
      <Route path="/project6a_coverage_develop" component={Project6a_develop} />
      <Route path="/project6a_coverage_latest" component={Project6a_rhi} />
      <Route path="/project7" component={Project7} />
    
  </main>

  <footer class="rounded-lg bg-[rgba(0,0,0,0.35)] text-gray-100 p-10 mt-10 mx-8 flex justify-between items-center">
    <div class="flex flex-col space-y-2 justify-end">
      
      
      <a href="mailto:shakarim.sanjar@gmail.com" class="mr-4 hover:underline">shakarim.sanjar@gmail.com</a>
      <a href="https://www.linkedin.com/in/sanzhar-shakarim-248497205/" class="mr-4 hover:underline">LinkedIn: Sanzhar Shakarim</a>
      <a href="https://t.me/Sanchozver/" class="mr-4 hover:underline">Telegram</a>
      
    </div>
    <div>
      <div class="flex flex-col space-y-2 justify-end">
        <a href="/" class="hover:underline">Home</a>
        <a href="/projects" class="hover:underline">Projects</a>
        <a href="/cv" class="hover:underline">CV</a>
      </div>
    </div>
  </footer>

  <div> 
    <p class="text-[rgba(0,0,0,0)]"> 0 </p>
  <p>
  </div>
</div>
</Router>

<style lang="postcss">
      .background-container {
        background-color: rgba(22, 25, 39, 0.753);
      /* background-image: url("src/assets/background.jpg");  */
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      width: 100%;
      min-height: 100vh;
      position: absolute;
      top: 0;
      left: 0;
      z-index: -1;
    }
  
</style>
