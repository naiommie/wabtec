<script>
  import { Router, Route } from 'svelte-routing';
  import CV from './CV.svelte';
  import Home from './Home.svelte';
  import Projects from './Projects.svelte';
  import Project1 from './Project1.svelte';
  import Project2 from './Project2.svelte';
  import Project3 from './Project3.svelte';
  import Project4 from './Project4.svelte';
  import Project5 from './Project5.svelte';
  import Project6 from './Project6.svelte';
  import Project6a from './Project6a.svelte';
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
    
      <Route path="/" component={Home} />
      <Route path="/cv" component={CV} />
      <Route path="/projects" component={Projects} />
      <Route path="/project1" component={Project1} />
      <Route path="/project2" component={Project2} />
      <Route path="/project3" component={Project3} />
      <Route path="/project4" component={Project4} />
      <Route path="/project5" component={Project5} />
      <Route path="/project6" component={Project6} />
      <Route path="/project6a" component={Project6a} />
    
  </main>

  <footer class="rounded-lg bg-[rgba(0,0,0,0.35)] text-gray-100 p-10 mt-10 mx-8 flex justify-between items-center">
    <div class="flex flex-col space-y-2 justify-end">
      
      
      <a href="mailto:sanzhar.shakarim@wabtec.com" class="mr-4 hover:underline">sanzhar.shakarim@wabtec.com</a>
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
         background-color: rgb(48, 60, 78);
      /*background-image: url("src/assets/background.jpg"); */
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
