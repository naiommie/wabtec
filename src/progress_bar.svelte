<script>
    export let value;
  </script>

<div class="px-2 py-1 text-lg">
    <div class="w-full h-4 bg-gray-300 rounded">
      <div
        style="width: {parseFloat(value) / 100 * 100}%; background-color: {parseFloat(value) < 75 ? 'red' : parseFloat(value) >= 75 && parseFloat(value) < 90 ? 'yellow' : 'green'};"
        class="h-4 rounded"
      >
      </div>
  </div>

</div>
