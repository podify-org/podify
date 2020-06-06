<template>
<div id="new-request" class="mb-4">
  <b-form @submit="onSubmit" class="vld-parent">
    <loading :active="submitting" :is-full-page="false" loader="dots"></loading>

    <label class="sr-only" for="url">URL</label>
    <b-input-group class="flex-fill">
      <b-form-input
        id="url"
        v-model="form.url"
        size="lg"
        required
        autofocus
        :disabled="submitting"
        placeholder="https://..."
        ></b-form-input>
      <div class="input-group-append">
        <b-button type="submit" size="lg" variant="primary" :disabled="submitting">
          Add
        </b-button>
      </div>
    </b-input-group>
  </b-form>
</div>
</template>

<script>
import gql from 'graphql-tag';
import Loading from 'vue-loading-overlay';

export default {
  data() {
    return {
      form: {
        url: '',
      },
      submitting: false,
    };
  },
  methods: {
    onSubmit(evt) {
      evt.preventDefault();
      this.submitting = true;

      this.$store.dispatch('createRequest', {
        apollo: this.$apollo,
        params: {
          url: this.form.url,
          feedId: parseInt(this.$route.params.feedId),
        },
      }).then(() => this.form.url = '')
        .catch(errors => alert(errors.join("\n")))
        .finally(() => this.submitting = false);
    },
  },
  components: {
    Loading,
  },
}
</script>

<style scoped>
</style>
