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
export default {
  props: ['request'],
  data() {
    return {
      submitting: false,
    };
  },
  computed: {
    feeds() {
      return this.$store.state.feeds.all.map(feed => {
        feed.current = feed.id == this.request.feedId;
        return feed;
      });
    },
  },
  methods: {
    onSelect(feedId) {
      this.$emit('submit', true);

      this.$store.dispatch('updateRequest', {
        apollo: this.$apollo,
        params: {
          id: this.request.id,
          feedId
        }
      })
        .then(() => this.$emit('submit', false))
        .catch(errors => alert(errors.join("\n")));
    },
  },
}
</script>

<style scoped>
</style>
