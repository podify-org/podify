import gql from 'graphql-tag';

export default {
  requests: gql`
    query {
      requests {
        id
        source {
          id
          url
          downloads {
            id
            title
            author
            thumbnailUrl
          }
        }
      }
    }
  `,
};
