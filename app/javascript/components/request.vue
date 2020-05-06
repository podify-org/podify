<template>
<Source :source="request.source">
  <template v-slot:thumbnail-actions>
    <DestroyRequest :id="request.id" @destroy="onDestroy" />
  </template>
  <template v-slot:body-start>
    <Loading :active="destroying" :is-full-page="false" loader="dots"></Loading>
  </template>
</Source>
</template>

<script>
import DestroyRequest from 'components/destroy_request';
import Source from 'components/source';
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
    Source,
    Loading,
  },
}
</script>
