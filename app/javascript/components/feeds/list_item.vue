<template>
<li v-if="!destroying">
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
               @destroy="onDestroy"
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
  data() {
    return {
      destroying: false,
    };
  },
  methods: {
    onDestroy(state) {
      this.destroying = state;
    },
  },
  components: {
    Subscribe,
    Destroy,
  },
}
</script>
