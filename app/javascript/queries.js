import gql from 'graphql-tag';

const fullSource = `
  id
  url
  title
  author
  description
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
    downloadUrl
  }
`;

const fullRequest = `
  id
  source {
    ${fullSource}
  }
`;

const fullFeed = `
  id
  token
  name
  rssUrl
`;

export const queryPartials = {
  fullSource,
  fullRequest,
};

export default {
  data: gql`
    query {
      data {
        requests {
          ${fullRequest}
        }
        feeds {
          ${fullFeed}
        }
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
