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
       :class="{ disabled: feed.current }"
       >
      {{ feed.name }}
    </a>
  </div>
</span>
</template>

<script>
import mutations from 'mutations';
import { readFeeds, updateRequest } from 'store';

export default {
  props: ['request'],
  data() {
    return {
      submitting: false,
    };
  },
  computed: {
    feeds() {
      return readFeeds(window.store).map(feed => {
        feed.current = feed.id == this.request.feedId;
        console.log(feed);
        return feed;
      });
    },
  },
  methods: {
    onSelect(feedId) {
      this.$emit('submit', true);

      this.$apollo.mutate({
        mutation: mutations.updateRequest,
        variables: { id: this.request.id, feedId },
        update: (store, { data: { updateRequest: { request, errors } } }) => {
          if (errors.length > 0) {
            alert(errors.join("\n"));
          } else {
            updateRequest(store, this.id, request);
          }

          this.$emit('submit', false);
        },
      });
    },
  },
}
</script>

<style scoped>
</style>
