<template>
  <div class="source-wrapper">
    <div class="source card">
      <Thumbnail :image="source.thumbnailUrl">
        <template v-slot:actions>
          <slot name="thumbnail-actions"></slot>
        </template>
      </Thumbnail>

      <div class="source-body vld-parent">
        <slot name="body-start"></slot>
        <Loading :active="source.downloadStatus.status == 'pending'" :is-full-page="false"></Loading>

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

export default {
  props: ['source'],
  components: {
    SourceStatus,
    Thumbnail,
    Loading,
  },
}
</script>
