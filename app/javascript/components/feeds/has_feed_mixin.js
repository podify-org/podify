export default {
  computed: {
    feed() {
      return this.$store.getters.feedById(this.$route.params.feedId);
    },
    feedRoute() {
      return { name: 'feedIndex', params: { feedId: this.feed.id } }
    },
  },
  methods: {
    addRequest(url) {
      this.$store.dispatch('createRequest', {
        apollo: this.$apollo,
        url: url,
        feedId: parseInt(this.feed.id),
      }).catch(this.$errorToaster.handler());
    },
  },
}
