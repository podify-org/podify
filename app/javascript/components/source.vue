<template>
  <div class="source-wrapper">
    <div class="source card vld-parent">
      <slot name="body-start"></slot>

      <Thumbnail :image="source.thumbnailUrl">
        <template v-slot:actions-bottom-right>
          <template v-if="source.lastDownload && source.lastDownload.downloadUrl">
            <b-button class="action">
              <a :href="source.lastDownload.downloadUrl"><b-icon-download></b-icon-download></a>
            </b-button>
            <b-button class="action" @click="playSource(source)">
              <i class="fas fa-play"></i>
            </b-button>
          </template>
        </template>
        <template v-slot:actions-top-right>
          <slot name="thumbnail-actions"></slot>
        </template>
        <template v-slot:placeholder>
          <i v-if="source.downloadStatus.status != 'downloaded'" class="fas fa-cloud-download-alt"></i>
          <i v-else-if="!source.thumbnailUrl && source.lastDownload && source.lastDownload.format == 'mp3'" class="fa fa-headphones"></i>
          <i v-else-if="!source.thumbnailUrl && source.lastDownload && source.lastDownload.format == 'mp4'" class="fa fa-video"></i>
        </template>
      </Thumbnail>

      <div class="source-body vld-parent">
        <Loading :active="source.downloadStatus.status == 'pending'" :is-full-page="false" loader="dots"></Loading>

        <b-card-title v-if="source.title" class="source-title">
          {{ source.title }}
        </b-card-title>
        <b-card-title v-else class="source-title">
          {{ source.url }}
        </b-card-title>

        <b-card-sub-title v-if="source.author" class="source-author">
          {{ source.author }}
        </b-card-sub-title>

        <p class="card-text">
          <SourceStatus :source="source"></SourceStatus>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import SourceStatus from 'components/source_status';
import Thumbnail from 'components/thumbnail';
import Loading from 'vue-loading-overlay';
import { state as playerState } from 'components/player';

export default {
  props: ['source'],
  components: {
    SourceStatus,
    Thumbnail,
    Loading,
  },
  methods: {
    playSource(source) {
      playerState.source = source;
    },
  },
}
</script>
