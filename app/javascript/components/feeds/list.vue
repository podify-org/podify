<template>
<div>
  <ul class="top nav">
    <li class="nav-item">
      <a class="nav-link disabled">
        <strong>Feeds</strong>
      </a>
    </li>
    <ListItem v-for="feed in feeds" :key="feed.id" :feed="feed"></ListItem>
  </ul>
  <NewFeed></NewFeed>
</div>
</div>

</template>

<script>
import NewFeed from 'components/feeds/new';
import ListItem from 'components/feeds/list_item';

export default {
  props: ['feeds'],
  components: {
    NewFeed,
    ListItem,
  },
}
</script>
