<template>
<div id="new-request" class="mb-4">
  <b-form @submit="onSubmit">
    <label class="sr-only" for="url">URL</label>
    <b-input-group class="flex-fill">
      <!--
          <div class="input-group-prepend">
            <b-input-group-text size="lg">
              <b-icon icon="download" />
            </b-input-group-text>
          </div>
      -->
      <b-form-input
        id="url"
        v-model="form.url"
        size="lg"
        required
        autofocus
        placeholder="https://..."
        ></b-form-input>
      <div class="input-group-append">
        <b-button type="submit" size="lg" variant="primary">Add</b-button>
      </div>
    </b-input-group>
  </b-form>
</div>
</template>

<script>
export default {
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
      this.form.url = '';
    },
  },
}
</script>

<style scoped>
</style>
