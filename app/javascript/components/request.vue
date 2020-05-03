<template>
<div class="source row mb-3">
  <div class="col">
    <b-card class="vld-parent overflow-hidden" no-body>
      <Loading :active="destroying" :is-full-page="false" loader="dots"></Loading>

      <template v-slot:header>
        <DestroyRequest :id="request.id" @destroy="onDestroy" />
        <span class="text-muted">{{ request.source.url }}</span>
      </template>

      <!-- <template v-slot:footer> -->
      <!--   Foot -->
      <!-- </template> -->

      <b-card-text>
        <b-media>
          <template v-slot:aside>
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
          </template>

          <div class="source-body py-2 pr-3">
            <b-card-title v-if="request.source.title">
              {{ request.source.title }}
            </b-card-title>
            <b-card-sub-title v-if="request.source.author">
              {{ request.source.author }}
            </b-card-sub-title>
            <div v-if="request.source.lastDownload" class="position-relative">
              <b-badge>{{ request.source.lastDownload.format }}</b-badge>
              <b-badge>{{ request.source.lastDownload.size }}</b-badge>
            </div>
          </div>
        </b-media>
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

<style lang="scss" scoped>
  .source-thumbnail {
    width: 150px;
    height: 150px;
    background-color: #000000;

    img {
      max-height: 100%;
      max-width: 100%;
      display: block;
      margin: 0 auto;
    }
  }

  .card-text {
    margin-bottom: 0;
  }
</style>
