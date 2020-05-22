<template>
<div>
  <ul class="top nav">
    <li class="nav-item">
      <a class="nav-link disabled">
        <strong>Feeds</strong>
      </a>
    </li>
    <li v-for="feed in feeds" :key="feed.id">
      <a class="nav-link">
        {{ feed.name }}
      </a>
    </li>
  </ul>
  <NewFeed></NewFeed>
</div>
</div>

</template>

<script>
import NewFeed from 'components/feeds/new';

export default {
  props: ['feeds'],
  components: {
    NewFeed,
  },
}
</script>
