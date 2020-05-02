<template>
<div class="request">
  <Source v-bind:source="request.source" />
</div>
</template>

<script>
import Source from 'components/source';

export default {
  props: ['request'],
  components: {
    Source,
  },
}
</script>

<style scoped>
</style>
