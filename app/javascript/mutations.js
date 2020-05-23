import gql from 'graphql-tag';
import { queryPartials } from 'queries';

export default {
  requestForUrl: gql`
    mutation request_for_url($url: String!, $feedId: Int!) {
      requestForUrl(input: {url: $url, feedId: $feedId}) {
        request {
          ${queryPartials.fullRequest}
        }
        errors
      }
    }
  `,
  destroyRequest: gql`
    mutation destroy_request($id: Int!) {
      destroyRequest(input: {id: $id}) {
        errors
      }
    }
  `,
  updateRequest: gql`
    mutation update_request($id: Int!, $feedId: Int) {
      updateRequest(input: {id: $id, feedId: $feedId}) {
        request {
          ${queryPartials.fullRequest}
        }
        errors
      }
    }
  `,
  createFeed: gql`
    mutation create_feed($name: String!) {
      createFeed(input: {name: $name}) {
        feed {
          ${queryPartials.fullFeed}
        }
        errors
      }
    }
  `,
  destroyFeed: gql`
    mutation destroy_feed($id: Int!) {
      destroyFeed(input: {id: $id}) {
        errors
      }
    }
  `,
};
