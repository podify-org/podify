<template>
<span>
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
import mutations from 'mutations';
import { updateFeed, removeFeed } from 'store';

export default {
  props: ['feed'],
  methods: {
    destroy() {
      this.$router.replace('/');
      this.$emit('destroy', true);

      this.$nextTick(() => {
        this.$apollo.mutate({
          mutation: mutations.destroyFeed,
          variables: { id: this.feed.id },
          update: (store, { data: { destroyFeed: { errors } } }) => {
            if (errors.length > 0) {
              this.$emit('destroy', false);
              alert(errors.join("\n"));
            } else {
              removeFeed(store, this.feed.id);
            }
        },
      });
      });
    },
  },
}
</script>
