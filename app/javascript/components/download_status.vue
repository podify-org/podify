<template>
  <div>
    <b-progress v-if="status.status == 'downloading'"
                :value="45" :max="100" variant="info" show-progress animated></b-progress>

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
  export default {
  props: ['status'],
}
</script>

<style lang="scss" scoped>
</style>
