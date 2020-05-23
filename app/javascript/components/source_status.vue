<template>
<div class="source-status">
  <div class="source-download-status">
    <template v-if="source.lastDownload">
      <b-badge variant="success">{{ source.lastDownload.format }}</b-badge>
      <b-badge variant="success">{{ source.lastDownload.size }}</b-badge>
    </template>

    <b-badge v-if="source.downloadStatus.status == 'retrying'" variant="warning">
      {{ source.downloadStatus.retryStatus }}
    </b-badge>

    <b-badge v-else-if="source.downloadStatus.status == 'dead'" variant="danger">
      Failed
    </b-badge>

    <b-badge v-else-if="source.downloadStatus.status == 'pending'" variant="info">
      Pending
    </b-badge>

    <b-badge v-else-if="source.downloadStatus.status == 'unknown'" variant="danger">
      Missing
    </b-badge>
  </div>

  <div class="source-download-progress">
    <b-progress v-if="source.downloadStatus.status == 'downloading'"
                :value="source.downloadStatus.progress" :max="100" variant="success" animated></b-progress>

    <b-progress v-else-if="source.downloadStatus.status == 'queued'"
                :max="100" variant="warning" label="Test" animated>
      <b-progress-bar :value="100">{{ source.downloadStatus.placeInQueue }}</b-progress-bar>
    </b-progress>
  </div>
</div>
</template>

<script>
import { updateDownloadStatus, refreshSource } from 'store';

export default {
  props: ['source'],
  channels: {
    DownloadStatusChannel: {
      connected() {},
      rejected() {},
      disconnected() {},
      received(data) {
        updateDownloadStatus(store, data.source_id, data.status);
      },
    }
  },
  mounted() {
    if (this.source.downloadStatus.status == 'downloaded') return;

    this.$cable.subscribe({
      channel: 'DownloadStatusChannel',
      source: this.source.id,
    });
    // this.poll();
  },
  methods: {
    poll() {
      if (['pending', 'retrying', 'queued'].includes(this.source.downloadStatus.status)) {
        // TODO: stop using global store
        refreshSource(store, this.source.id);
      }
      setTimeout(() => {
        this.poll();
      }, 1000);
    },
  },
  watch: {
    'source.downloadStatus.status': {
      handler(val, oldVal) {
        if (val == 'downloaded') {
          // TODO: stop using global store
          refreshSource(store, this.source.id);
        }
      },
    },
  },
}
</script>

<style lang="scss" scoped>
</style>
