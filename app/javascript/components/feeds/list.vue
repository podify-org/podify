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
import mutations from 'mutations';
import { updateData } from 'store';

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

      this.$apollo.mutate({
        mutation: mutations.orderFeeds,
        variables: { feedIds },
        update: (store, { data: { orderFeeds: { feeds } } }) => {
          updateData(store, data => data.feeds = feeds);
        },
      });
    },
  },
  components: {
    NewFeed,
    ListItem,
    Draggable,
  },
}
</script>
