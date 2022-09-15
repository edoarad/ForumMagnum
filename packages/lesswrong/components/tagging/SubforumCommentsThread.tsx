import React from 'react';
import { Components, registerComponent } from '../../lib/vulcan-lib';
import { useMulti } from '../../lib/crud/withMulti';
import { unflattenComments } from "../../lib/utils/unflatten";

const SubforumCommentsThread = ({ tag, terms, newForm=true }: {
  tag: TagBasicInfo,
  terms: CommentsViewTerms,
  newForm?: boolean,
}) => {
  const { loading, results, loadMore, loadingMore, totalCount, refetch } = useMulti({
    terms,
    collectionName: "Comments",
    fragmentName: 'CommentWithRepliesFragment',
    fetchPolicy: 'cache-and-network',
    enableTotal: true,
  });
  
  if (loading && !results) {
    return <Components.Loading />;
  } else if (!results) {
    return null;
  }

  return (
    <Components.CommentsTimelineSection
      tag={tag}
      comments={results}
      loadMoreComments={loadMore}
      totalComments={totalCount as number}
      commentCount={(results && results.length) || 0}
      loadingMoreComments={loadingMore}
      loadMoreCount={50}
      newForm={newForm}
      refetch={refetch}
    />
  );
}

const SubforumCommentsThreadComponent = registerComponent('SubforumCommentsThread', SubforumCommentsThread, {
  areEqual: {
    terms: "deep",
  }
});

declare global {
  interface ComponentTypes {
    SubforumCommentsThread: typeof SubforumCommentsThreadComponent
  }
}
