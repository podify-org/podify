<template>
<div>
  <div class="requests row">
    <Request v-for="request in requests" :key="request.id" :request="request" />
  </div>
</div>
</template>

<script>
import Request from 'components/request';

export default {
  props: ['requests'],
  components: {
    Request,
  }
}
</script>
