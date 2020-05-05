<template>
<div class="source row mb-3">
  <div class="col">
    <b-card class="vld-parent overflow-hidden" no-body>
      <Loading :active="destroying" :is-full-page="false" loader="dots"></Loading>

      <template v-slot:header>
        <DestroyRequest :id="request.id" @destroy="onDestroy" />
        <span class="text-muted">{{ request.source.url }}</span>
      </template>

      <b-card-text class="vld-parent source-card-body">
        <Loading :active="request.source.downloadStatus.status == 'pending'" :is-full-page="false"></Loading>

        <div class="source-thumbnail d-flex flex-wrap align-items-center">
          <b-img
            v-if="request.source.thumbnailUrl"
            :src="request.source.thumbnailUrl"
            fluid
            ></b-img>
          <b-img
            v-else
            blank blank-color="#ccc"
            class="w-100 h-100"
            width="90"
            alt="placeholder"
            ></b-img>
        </div>

        <div class="source-body">
          <div class="source-text">
            <b-card-title v-if="request.source.title" class="source-title">
              {{ request.source.title }}
            </b-card-title>
            <b-card-sub-title v-if="request.source.author" class="source-author">
              {{ request.source.author }}
            </b-card-sub-title>
          </div>


          <SourceStatus :source="request.source"></SourceStatus>
        </div>
      </b-card-text>
    </b-card>
  </div>
</div>
</template>

<script>
import DestroyRequest from 'components/destroy_request';
import SourceStatus from 'components/source_status';
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
    SourceStatus,
    Loading,
  },
}
</script>
