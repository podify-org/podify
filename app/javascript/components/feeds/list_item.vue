<template>
<li>
  <div class="feeds-list-item nav-link">
    <router-link class="feed-name"
                 :to="{ name: 'feedRequests', params: { feedId: feed.id }}"
                 >
      {{ feed.name }}
    </router-link>

    <div class="feed-actions">
      <Subscribe :feed="feed" scope="sidebar"></Subscribe>
      <i class="feed-action fas fa-trash" @click="destroy"></i>
    </div>
  </div>
</li>
</div>

</template>

<script>
import mutations from 'mutations';
import { removeFeed } from 'store';
import Subscribe from 'components/subscribe';

export default {
  props: ['feed'],
  data() {
    return {
      destroying: false,
    };
  },
  methods: {
    destroy() {
      this.destroying = true;

      this.$apollo.mutate({
        mutation: mutations.destroyFeed,
        variables: { id: this.feed.id },
        update: (store, { data: { destroyFeed: { errors } } }) => {
          if (errors.length > 0) {
            alert(errors.join("\n"));
          } else {
            removeFeed(store, this.feed.id);
          }

          this.destroying = false;
        },
      });
    },
  },
  components: {
    Subscribe,
  },
}
</script>
