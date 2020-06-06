<template>
<span v-if="!feed._optimisticCreate">
  <i class="feed-action fas fa-trash"
     id="dropdownMenuButton"
     data-toggle="dropdown"
     aria-haspopup="true"
     aria-expanded="false"
     ></i>

  <div class="dropdown-menu p-3"
       aria-labelledby="dropdownMenuButton">
    <p>
      Are you sure? This will delete all downloads in this feed.
    </p>
    <p class="mb-0">
      <button class="btn btn-danger btn-sm"
              @click="destroy">
        Confirm
      </button>
    </p>
  </div>
</span>
</div>

</template>

<script>
export default {
  props: ['feed'],
  methods: {
    destroy() {
      this.$router.replace('/');
      this.$emit('destroy', true);

      this.$nextTick(() => {
        this.$store.dispatch('destroyFeed', { apollo: this.$apollo, id: this.feed.id })
          .catch(this.$errorToaster.handler());
      });
    },
  },
}
</script>
