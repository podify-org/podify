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
import Loading from 'vue-loading-overlay';

const ADD_REQUEST = gql`
  mutation request_for_url($url: String!) {
    requestForUrl(input: {url: $url}) {
      request {
        id
        source {
          id
          url
          downloads {
            id
            title
          }
        }
      }
      errors
    }
  }
`;

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
        mutation: ADD_REQUEST,
        variables: { url: this.form.url },
        update: (store, { data: { requestForUrl: { request, errors } } }) => {
          if (errors.length > 0) {
            alert(errors.join("\n"));
          } else {
            const data = store.readQuery({ query: queries.requests });
            data.requests.unshift(request);
            store.writeQuery({ query: queries.requests, data });
          }

          this.submitting = false;
          this.form.url = '';
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
