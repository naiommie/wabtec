<script>
    export let label;
    export let sortColumn;
    export let sortDirection;
    export let onSort;
  </script>
  
  <th
    scope="col"
    class="px-2 py-1 text-center text-lg cursor-pointer"
    on:click={onSort}
  >
    {label} {sortColumn === label ? (sortDirection === 'asc' ? '⬆' : '⬇') : '⬆⬇'}
  </th>