<template>
<Source :source="request.source">
  <template v-slot:thumbnail-actions-top-right>
    <DestroyRequest :id="request.id" @destroy="onDestroy" />
  </template>

  <template v-slot:thumbnail-actions-bottom-left>
    <ChangeFeed :request="request" />
  </template>

  <template v-slot:body-start>
    <Loading :active="destroying || changingFeed" :is-full-page="false" loader="dots"></Loading>
  </template>
</Source>
</template>

<script>
import DestroyRequest from 'components/requests/destroy';
import ChangeFeed from 'components/requests/change_feed';
import Source from 'components/source';
import Loading from 'vue-loading-overlay';

export default {
  props: ['request'],
  data() {
    return {
      destroying: false,
      changingFeed: false,
    };
  },
  methods: {
    onDestroy(evt) {
      this.destroying = true;
    }
  },
  components: {
    DestroyRequest,
    ChangeFeed,
    Source,
    Loading,
  },
}
</script>
