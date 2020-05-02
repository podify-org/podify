<template>
<div id="requests">
  <NewRequest />
  <div v-if="$apolloData.loading" class="d-flex mb-3 justify-content-center">
    <b-spinner type="border" variant="primary"></b-spinner>
  </div>
  <div v-for="request in requests" :key="request.id">
    <Request :request="request" />
  </div>
</div>
</template>

<script>
import gql from 'graphql-tag';
import Request from 'components/request';
import NewRequest from 'components/new_request';

const GET_ALL_REQUESTS = gql`
  query {
    requests {
      id
      source {
        id
        url
        downloads {
          id
          title
        }
      }
    }
  }
`;

export default {
  apollo: {
    requests: {
      query: GET_ALL_REQUESTS,
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
