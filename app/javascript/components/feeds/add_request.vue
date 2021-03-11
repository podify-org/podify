<template>
</template>

<script>
import HasFeed from 'components/feeds/has_feed_mixin.js';

export default {
  mixins: [HasFeed],
  computed: {
    url() { return this.$route.query.url },
  },
  mounted() {
    if (this.url) {
      this.addRequest(this.url)
    } else {
      this.$nextTick(() => {
        this.$errorToaster.handle("No URL given ('?url=...')")
      })
    }

    this.$router.replace(this.feedRoute)
  },
}
</script>
