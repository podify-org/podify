<template>
<div id="new-request" class="mb-4">
  <b-form @submit="onSubmit">
    <label class="sr-only" for="url">URL</label>
    <b-input-group class="flex-fill">
      <b-form-input
        id="url"
        v-model="form.url"
        size="lg"
        required
        autofocus
        placeholder="https://..."
        ></b-form-input>
      <div class="input-group-append">
        <b-button type="submit" size="lg" variant="primary">
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

import HasFeed from 'components/feeds/has_feed_mixin.js';

export default {
  mixins: [HasFeed],
  data() {
    return {
      form: {
        url: '',
      },
    };
  },
  methods: {
    onSubmit(evt) {
      evt.preventDefault();
      this.addRequest(this.form.url)
      this.form.url = '';
    },
  },
  components: {
    Loading,
  },
}
</script>

<style scoped>
</style>
