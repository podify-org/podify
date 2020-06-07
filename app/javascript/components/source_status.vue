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
export default {
  props: ['source'],
}
</script>
