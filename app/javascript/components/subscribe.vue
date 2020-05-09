<template>
<div class="subscribe">
  <div class="subscribe-icon" v-b-modal.modal-1>
    <i class="fas fa-rss"></i>

    <b-modal id="modal-1" :title="'Subscribe to Podify: ' + feed.name" ok-only hide-footer>

      <p>Import this feed into your favorite podcast app:</p>

      <div class="input-group mb-3">
        <input type="text"
               v-model="feed.rssUrl"
               class="form-control"
               @focus="$event.target.select()"
               >

        <div v-if="copyState != 'fail'" class="input-group-append">
          <button type="button"
                  :class="{ btn: true, 'btn-primary': copyState != 'success', 'btn-success': copyState == 'success'}""
                  v-clipboard:copy="feed.rssUrl"
                  v-clipboard:success="onCopy"
                  v-clipboard:error="onError">
            <span v-if="copyState == 'success'"><i class="fas fa-check"></i></span>
            <span v-else><i class="fas fa-copy"></i></span>
          </button>
        </div>
      </div>

      <small v-if="copyState == 'fail'" class="form-text text-muted">
        Coudn't copy the URL, try copying it manually.
      </small>

      <p>or <a :href="feed.rssUrl" target="_blank">click here</a>.</p>
    </b-modal>
  </div>
</div>
</template>

<script>
export default {
  props: ['feed'],
  data() {
    return {
      copyState: 'pending',
    };
  },
  methods: {
    onCopy: function (e) {
      this.copyState = 'success';
    },
    onError: function (e) {
      this.copyState = 'fail';
    },
  },
}
</script>
