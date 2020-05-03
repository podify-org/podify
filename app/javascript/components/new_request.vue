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
import queries from 'queries';
import mutations from 'mutations';
import { updateRequests } from 'store';
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

      this.$apollo.mutate({
        mutation: mutations.requestForUrl,
        variables: { url: this.form.url },
        update: (store, { data: { requestForUrl: { request, errors } } }) => {
          if (errors.length > 0) {
            alert(errors.join("\n"));
          } else {
            updateRequests(store, requests => {
              requests.unshift(request);
            })
            this.form.url = '';
          }
          this.submitting = false;
        },
      });
    },
  },
  components: {
    Loading,
  },
}
</script>

<style scoped>
</style>
