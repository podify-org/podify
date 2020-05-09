<template>
  <div class="card-img-top source-thumbnail-wrapper">
    <b-img
      v-if="image"
      class="source-thumbnail"
      :src="image"
      fluid
      ></b-img>

    <template v-else>
      <b-img
        class="source-thumbnail placeholder"
        blank blank-color="#000000"
        alt="placeholder"
        ></b-img>
      <div class="placeholder-icon">
        <slot name="placeholder"></slot>
      </div>
    </template>

    <div class="actions top right">
      <slot name="actions-top-right"></slot>
    </div>
    <div class="actions bottom right">
      <slot name="actions-bottom-right"></slot>
    </div>
  </div>
</template>

<script>
export default {
  props: ['image'],
}
</script>
