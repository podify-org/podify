<template>
<div>
  <ul class="top nav">
    <li class="nav-item">
      <a class="nav-link disabled">
        <strong>Feeds</strong>
      </a>
    </li>
    <Draggable v-model="sortableFeeds" @end="onDragEnd">
      <ListItem v-for="feed in sortableFeeds" :key="feed.id" :feed="feed"></ListItem>
    </Draggable>
  </ul>
  <NewFeed></NewFeed>
</div>
</div>

</template>

<script>
import NewFeed from 'components/feeds/new';
import ListItem from 'components/feeds/list_item';
import Draggable from 'vuedraggable'

export default {
  props: ['feeds'],
  data() {
    return {
      sortableFeeds: this.feeds,
    };
  },
  methods: {
    onDragEnd(x, y) {
      const feedIds = this.sortableFeeds.map(f => f.id);
      this.$store.dispatch('orderFeeds', { apollo: this.$apollo, feedIds });
    },
  },
  components: {
    NewFeed,
    ListItem,
    Draggable,
  },
}
</script>
