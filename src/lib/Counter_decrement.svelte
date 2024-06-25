<script lang="ts">
  let count: number = 0
  const decrement = () => {
    count -= 1
  }
</script>

<button on:click={decrement}>
  count is {count}
</button>
