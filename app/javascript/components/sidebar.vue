<template>
<aside id="sidebar" class="sidebar" :class="{ active: active }">
  <FeedList :feeds="feeds"></FeedList>

  <ul class="bottom nav">
    <li class="nav-item">
      <a class="nav-link" data-method="delete" href="/user/sign_out">
        Sign out
      </a>
    </li>
  </ul>
</aside>
</template>

<script>
import FeedList from 'components/feeds/list';

export default {
  props: ['active'],
  computed: {
    feeds() { return this.$store.state.feeds.all; },
  },
  components: {
    FeedList
  },
}
</script>
