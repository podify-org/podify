<template>
<div id="app">
  <Navbar></Navbar>
  <Requests></Requests>
</div>
</template>

<script>
import Requests from 'components/requests';
import Navbar from 'components/navbar';

export default {
  components: {
    Requests,
    Navbar,
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
