<template>
  <button @click="onClick" :disabled="submitting" class="action"><i class="fas fa-times"></i></button>
</template>

<script>
import mutations from 'mutations';
import { removeRequest } from 'store';

export default {
  props: ['id'],
  data() {
    return {
      submitting: false,
    };
  },
  methods: {
    onClick(evt) {
      evt.preventDefault();
      this.submitting = true;
      this.$emit("destroy");

      this.$apollo.mutate({
        mutation: mutations.destroyRequest,
        variables: { id: this.id },
        update: (store, { data: { destroyRequest: { errors } } }) => {
          if (errors.length > 0) {
            alert(errors.join("\n"));
          } else {
            removeRequest(store, this.id);
          }

          this.submitting = false;
        },
      });
    },
  },
}
</script>

<style scoped>
</style>
