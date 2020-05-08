<template>
  <div class="card-img-top source-thumbnail-wrapper">
    <b-img
      v-if="image"
      class="source-thumbnail"
      :src="image"
      fluid
      ></b-img>
    <b-img
      v-else
      class="source-thumbnail placeholder"
      blank blank-color="#000000"
      alt="placeholder"
      ></b-img>

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
