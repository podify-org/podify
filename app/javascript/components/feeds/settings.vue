<template>
  <b-modal id="feed-settings-modal"
           :title="`Settings for ${feed.name}`"
           ref="modal"
           ok-only hide-footer
           @hidden="hidden"
           >

    <h5>Bookmarklet</h5>
    <Bookmarklet></Bookmarklet>

  </b-modal>
</template>

<script>
import Bookmarklet from 'components/feeds/bookmarklet';
import HasFeed from 'components/feeds/has_feed_mixin.js';

export default {
  mixins: [HasFeed],
  mounted() {
    this.$refs.modal.show()
    window.r = this.$router
  },
  methods: {
    hidden() {
      this.$router.replace(this.feedRoute)
    },
  },
  components: {
    Bookmarklet,
  },
}
</script>
