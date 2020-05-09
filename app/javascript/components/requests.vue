<template>
<div>
  <NewRequest />
  <div class="requests row">
    <Request v-for="request in requests" :key="request.id" :request="request" />
  </div>
</div>
</template>

<script>
import Request from 'components/request';
import NewRequest from 'components/new_request';

export default {
  props: ['requests'],
  components: {
    Request,
    NewRequest,
  }
}
</script>
