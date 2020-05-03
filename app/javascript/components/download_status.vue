<template>
  <div>
    <b-progress v-if="status.status == 'downloading'"
                :value="status.progress" :max="100" variant="info" animated></b-progress>

    <b-progress v-else-if="status.status == 'queued'"
                :max="100" variant="warning" label="Test" animated>
      <b-progress-bar :value="100">{{ status.placeInQueue }}</b-progress-bar>
    </b-progress>

    <b-badge v-else-if="status.status == 'retrying'" variant="warning">
      {{ status.retryStatus }}
    </b-badge>

    <b-badge v-else-if="status.status == 'dead'" variant="danger">
      Failed
    </b-badge>

    <b-badge v-else-if="status.status == 'unknown'" variant="danger">
      Missing
    </b-badge>
  </div>
</template>

<script>
import { updateDownloadStatus, refreshSource } from 'store';

export default {
  props: ['status', 'source-id'],
  channels: {
    DownloadStatusChannel: {
      connected() {},
      rejected() {},
      disconnected() {},
      received(data) {
        // TODO: stop using global store
        if (data.status.status == 'downloaded' && status.status != 'downloaded') {
          refreshSource(store, this.sourceId);
        }
        updateDownloadStatus(store, data.source_id, data.status);
      },
    }
  },
  mounted() {
    this.$cable.subscribe({
      channel: 'DownloadStatusChannel',
      source: this.sourceId,
    });
  },
}
</script>

<style lang="scss" scoped>
</style>
