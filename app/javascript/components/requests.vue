<template>
<div id="requests">
  <h3>Requests</h3>
  <div class="row" v-for="request in requests" v-bind:key="request.id">
    {{ request.id }}: {{ request.source.url }}
  </div>
</div>
</template>

<script>
import gql from 'graphql-tag';

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
}
</script>

<style scoped>
</style>
