<template>
  <div>
    Drag this to your bookmarks toolbar:
    <h4 class="mt-2">
      <b-badge pill variant="primary">
        <a class="bookmarklet" :href="href">
          Add to {{feed.name}}
        </a>
      </b-badge>
    </h4>
  </div>
</template>

<style scoped>
.bookmarklet, .no-decoration:hover {
  text-decoration: none;
  color: #FFFFFF;
}
</style>

<script>
import config from 'config'
import HasFeed from 'components/feeds/has_feed_mixin.js';

export default {
  mixins: [HasFeed],
  computed: {
    href() {
      let path = this.$router.match({name: "addRequest", params: { feedId: this.feed.id }}).path
      let url = config.rootUrl + path

      let script = `
        var url = location.href;
        var encodedUrl = encodeURIComponent(url);
        location.href = "${url}?url=" + encodedUrl
      `.replace(/^\s+|\n/mg, '')

      return "javascript:" + encodeURIComponent(script)
    },
  }
}
</script>
