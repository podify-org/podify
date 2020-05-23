<template>
<span>
  <button class="action" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <i class="fas fa-list"></i>
  </button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <a v-for="feed in feeds"
       :key="feed.id"
       class="dropdown-item"
       @click.prevent="onSelect(feed.id)"
       href="#"
       >
      {{ feed.name }}
    </a>
  </div>
</span>
</template>

<script>
import mutations from 'mutations';
import { readFeeds, removeRequest } from 'store';

export default {
  props: ['request'],
  data() {
    return {
      submitting: false,
    };
  },
  computed: {
    feeds() {
      return readFeeds(window.apollo.cache)
        .filter(feed => feed.id != this.request.feedId);
    },
  },
  methods: {
    onSelect(feedId) {
      console.log(feedId);
    },
  },
}
</script>

<style scoped>
</style>
