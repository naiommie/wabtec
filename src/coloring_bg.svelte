<script>
    export let value;
  </script>

    <div
    class="px-2 py-1 text-lg"
    style="background-color: {parseFloat(value) < 75 ? 'red' : parseFloat(value) >= 75 && parseFloat(value) < 90 ? 'yellow' : 'green'}; color: black; font-weight: bold;">
    {value}%
  </div>

      
