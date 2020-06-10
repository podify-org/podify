<template>
</template>

<script>
export default {
  props: {
    source: Object,
    pollRate: {
      type: Number,
      default: null,
    },
  },
  channels: {
    DownloadStatusChannel: {
      connected() {},
      rejected() {},
      disconnected() {},
      received(data) {
        this.$store.commit('updateDownloadStatus', { sourceId: data.source_id, ...data.status });
      },
    }
  },
  mounted() {
    if (this.source.downloadStatus.status == 'downloaded')
      return;

    this.subscribe();

    if (this.pollRate)
      this.queuePoll();
  },
  methods: {
    subscribe() {
      this.$cable.subscribe({
        channel: 'DownloadStatusChannel',
        source: this.source.id,
      });
    },
    unsubscribe() {
      this.$cable.unsubscribe({
        channel: 'DownloadStatusChannel',
        source: this.source.id,
      });
    },

    poll() {
      if (['pending', 'retrying', 'queued'].includes(this.source.downloadStatus.status)) {
        this.refreshSource()
          .catch(errors => console.warn(errors))
          .finally(() => {
            this.queuePoll();
          });
      }
    },
    queuePoll() {
      setTimeout(() => this.poll(), this.pollRate);
    },

    refreshSource() {
      return this.$store.dispatch('refreshSource', { apollo: this.$apollo, id: this.source.id });
    },
  },
  watch: {
    'source.downloadStatus.status': {
      handler(val, oldVal) {
        if (val == 'downloaded') {
          this.refreshSource()
            .catch(this.$errorToaster.handler());
          this.unsubscribe();
        }
      },
    },
  },
}
</script>
