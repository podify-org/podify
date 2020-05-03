import gql from 'graphql-tag';

export const queryPartials = {
  fullRequest: `
    id
    source {
      id
      url
      title
      author
      thumbnailUrl
      downloadStatus {
        status
        placeInQueue
        retryStatus
      }
      lastDownload {
        id
        title
        author
        thumbnailUrl
        format
        size
      }
    }
  `,
};

export default {
  requests: gql`
    query {
      requests {
        ${queryPartials.fullRequest}
      }
    }
  `,
};
