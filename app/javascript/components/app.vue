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

  <DownloadStatusSubscription v-for="source in sources"
                              v-if="source.id !== undefined"
                              :key="source.id"
                              :source="source"
                              :poll-rate="2000"
                              >
  </DownloadStatusSubscription>
</div>
</template>

<script>
import Navbar from 'components/navbar'
import Player from 'components/player'
import DownloadStatusSubscription from 'components/download_status_subscription'

export default {
  computed: {
    loading() { return this.$store.state.loading },
    sources() { return this.$store.getters.allSources },
  },
  mounted() {
    this.$store.dispatch('fetchData', this.$apollo)
      .catch(this.$errorToaster.handler())
  },
  updated() {
    // Redirect to first feed if not currently on one, or the current one does not exist
    if (this.$route.params.feedId === undefined ||
        !this.$store.getters.feedById(this.$route.params.feedId)) {
      this.$router.replace({ name: 'feedIndex', params: { feedId: this.$store.getters.defaultFeed.id } })
    }
  },
  components: {
    Navbar,
    Player,
    DownloadStatusSubscription,
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
