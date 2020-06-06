<template>
<div id="app">
  <div class="container">
    <div v-if="loading" class="d-flex mt-5 mb-3 justify-content-center">
      <b-spinner type="border" variant="primary"></b-spinner>
    </div>
    <template v-else>
      <Navbar></Navbar>

      <router-view></router-view>

      <Player></Player>
    </template>
  </div>
</div>
</template>

<script>
import Navbar from 'components/navbar';
import Player from 'components/player';

export default {
  components: {
    Navbar,
    Player,
  },
  computed: {
    loading() { return this.$store.state.loading; },
  },
  mounted() {
    this.$store.dispatch('fetchData', this.$apollo)
      .catch(this.$errorToaster.handler());
  },
  updated() {
    // Redirect to first feed if not currently on one, or the current one does not exist
    let feeds = this.$store.state.feeds.all;
    if (this.$route.params.feedId === undefined ||
        !feeds.find(f => f.id == this.$route.params.feedId)) {
      this.$router.replace({ name: 'feedIndex', params: { feedId: feeds[0].id } });
    }
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
