<template>
<li>
  <a v-if="!formOpen" class="nav-link new-feed-open-form" @click="openForm">
    <i class="fas fa-plus"></i>
  </a>

  <b-form v-if="formOpen"
          @submit="onSubmit"
          @keydown.esc="reset"
          class="vld-parent form-inline mx-3">
    <loading :active="submitting" :is-full-page="false" loader="dots"></loading>

    <label class="sr-only" for="url">Feed name</label>
    <b-input-group class="flex-fill">
      <b-form-input
        id="feed-name"
        v-model="form.name"
        size="sm"
        required
        autofocus
        :disabled="submitting"
        placeholder="Name"
        ></b-form-input>
      <div class="input-group-append">
        <b-button type="submit" size="sm" variant="primary" :disabled="submitting">
          <i class="fas fa-plus"></i>
        </b-button>
      </div>
    </b-input-group>
  </b-form>
</li>
</div>

</template>

<script>
import mutations from 'mutations';
import { addFeed } from 'store';
import Loading from 'vue-loading-overlay';

export default {
  data() {
    return {
      formOpen: false,
      submitting: false,
      form: {
        name: '',
      },
    };
  },
  methods: {
    openForm() {
      this.formOpen = true;
    },
    onSubmit(event) {
      event.preventDefault();
      this.submitting = true;

      this.$apollo.mutate({
        mutation: mutations.createFeed,
        variables: this.form,
        update: (store, { data: { createFeed: { feed, errors } } }) => {
          if (errors.length > 0) {
            alert(errors.join("\n"));
          } else {
            console.log(feed);
            addFeed(store, feed);
          }
          this.reset();
        },
      });
    },
    reset() {
      this.formOpen = false;
      this.submitting = false;
      this.form.name = '';
    },
  },
  components: {
    Loading,
  }
}
</script>
