import gql from 'graphql-tag';

const fullSource = `
  id
  url
  title
  author
  thumbnailUrl
  downloadStatus {
    status
    placeInQueue
    retryStatus
    progress
  }
  lastDownload {
    id
    title
    author
    thumbnailUrl
    format
    size
  }
`;

const fullRequest = `
  id
  source {
    ${fullSource}
  }
`;

export const queryPartials = {
  fullSource,
  fullRequest,
};

export default {
  requests: gql`
    query {
      requests {
        ${fullRequest}
      }
    }
  `,
  source: gql`
    query source($id: Int!) {
      source(id: $id) {
        ${fullSource}
      }
    }
  `,
};
