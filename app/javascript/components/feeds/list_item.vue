<template>
<li v-if="!feed._deleting">
  <div class="feeds-list-item nav-link">
    <router-link class="feed-name"
                 :to="{ name: 'feedIndex', params: { feedId: feed.id }}"
                 >
      {{ feed.name }}
    </router-link>

    <div class="feed-actions">
      <Subscribe :feed="feed" scope="sidebar"></Subscribe>
      <Destroy v-if="feed.type != 'all'"
               :feed="feed"
               ></Destroy>
    </div>
  </div>
</li>
</div>

</template>

<script>
import Subscribe from 'components/subscribe';
import Destroy from 'components/feeds/destroy';

export default {
  props: ['feed'],
  components: {
    Subscribe,
    Destroy,
  },
}
</script>
