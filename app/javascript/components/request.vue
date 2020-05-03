<template>
<div class="source row mb-3">
  <div class="col">
    <b-card v-bind:title="request.source.title" class="vld-parent">
      <Loading :active="destroying" :is-full-page="false" loader="dots"></Loading>

      <b-card-text>
        <DestroyRequest :id="request.id" @destroy="onDestroy" />
        <b-card-title v-if="request.source.downloads.length > 0">{{ request.source.downloads[0].title }}</b-card-title>
        <b-card-sub-title>{{ request.source.url }}</b-card-sub-title>
      </b-card-text>
    </b-card>
  </div>
</div>
</template>

<script>
import DestroyRequest from 'components/destroy_request';
import Loading from 'vue-loading-overlay';

export default {
  props: ['request'],
  data() {
    return {
      destroying: false
    };
  },
  methods: {
    onDestroy(evt) {
      this.destroying = true;
    }
  },
  components: {
    DestroyRequest,
    Loading,
  },
}
</script>

<style scoped>
</style>
