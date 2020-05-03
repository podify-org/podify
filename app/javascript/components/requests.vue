<template>
<div id="requests">
  <NewRequest />
  <div v-if="$apolloData.loading" class="d-flex mt-5 mb-3 justify-content-center">
    <b-spinner type="border" variant="primary"></b-spinner>
  </div>
  <div v-for="request in requests" :key="request.id">
    <Request :request="request" />
  </div>
</div>
</template>

<script>
import gql from 'graphql-tag';
import queries from 'queries';
import Request from 'components/request';
import NewRequest from 'components/new_request';

export default {
  apollo: {
    requests: {
      query: queries.requests,
    },
  },
  components: {
    Request,
    NewRequest,
  }
}
</script>

<style scoped>
</style>
