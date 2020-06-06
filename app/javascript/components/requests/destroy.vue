<template>
  <button @click="onClick" :disabled="submitting" class="action"><i class="fas fa-times"></i></button>
</template>

<script>
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

      this.$store.dispatch('destroyRequest', { apollo: this.$apollo, id: this.id })
        .catch(errors => alert(errors.join("\n")))
        .finally(() => this.submitting = false);
    },
  },
}
</script>

<style scoped>
</style>
