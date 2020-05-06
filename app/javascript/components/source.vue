<template>
<div class="source row mb-3">
  <div class="col">
    <b-card class="vld-parent overflow-hidden" no-body>
      <slot name="body-start"></slot>

      <template v-slot:header>
        <slot name="header"></slot>
        <span class="text-muted">{{ source.url }}</span>
      </template>

      <b-card-text class="source-body">
        <div class="source-thumbnail d-flex flex-wrap align-items-center">
          <b-img
            v-if="source.thumbnailUrl"
            :src="source.thumbnailUrl"
            fluid
            ></b-img>
          <b-img
            v-else
            blank blank-color="#000000"
            class="w-100 h-100"
            width="90"
            alt="placeholder"
            ></b-img>
        </div>

        <div class="vld-parent source-body">
          <Loading :active="source.downloadStatus.status == 'pending'" :is-full-page="false"></Loading>

          <div class="source-text">
            <b-card-title v-if="source.title" class="source-title">
              {{ source.title }}
            </b-card-title>
            <b-card-sub-title v-if="source.author" class="source-author">
              {{ source.author }}
            </b-card-sub-title>
            <b-card-text v-if="source.description" class="source-description">
              {{ source.description }}
            </b-card-text>
          </div>

          <SourceStatus :source="source"></SourceStatus>
        </div>
      </b-card-text>
    </b-card>
  </div>
</div>
</template>

<script>
import SourceStatus from 'components/source_status';
import Loading from 'vue-loading-overlay';

export default {
  props: ['source'],
  components: {
    SourceStatus,
    Loading,
  },
}
</script>
