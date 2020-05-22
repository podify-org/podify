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
  feedId
  source {
    ${fullSource}
  }
`;

const fullFeed = `
  id
  token
  name
  rssUrl
  type
`;

export const queryPartials = {
  fullSource,
  fullRequest,
  fullFeed,
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
