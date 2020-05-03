<template>
<div class="source row mb-3">
  <div class="col">
    <b-card v-bind:title="source.title">
      <b-card-text>
        <b-card-title v-if="source.downloads.length > 0">{{ source.downloads[0].title }}</b-card-title>
        <b-card-sub-title>{{ source.url }}</b-card-sub-title>
      </b-card-text>
    </b-card>
  </div>
</div>
</template>

<script>
export default {
  props: ['source'],
}
</script>

<style scoped>
</style>
