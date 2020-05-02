<template>
<div id="app" class="container">
  <Requests></Requests>
</div>
</template>

<script>
import Requests from 'components/requests';

export default {
  components: {
    Requests,
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
