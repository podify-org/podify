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
      lastDownload {
        id
        title
        author
        thumbnailUrl
        format
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
