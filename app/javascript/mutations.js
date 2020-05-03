import gql from 'graphql-tag';
import { queryPartials } from 'queries';

export default {
  requestForUrl: gql`
    mutation request_for_url($url: String!) {
      requestForUrl(input: {url: $url}) {
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
};
