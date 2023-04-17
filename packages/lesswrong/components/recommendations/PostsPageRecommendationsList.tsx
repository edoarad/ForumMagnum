import React from "react";
import { Components, registerComponent } from "../../lib/vulcan-lib";
import { usePostsPageContext } from "../posts/PostsPage/PostsPageContext";
import type { RecommendationsAlgorithmWithStrategy } from "../../lib/collections/users/recommendationSettings";

const PostsPageRecommendationsList = () => {
  const post = usePostsPageContext();
  if (!post) {
    return null;
  }

  const recommendationsAlgorithm: RecommendationsAlgorithmWithStrategy = {
    strategy: {
      name: "moreFromTag",
      postId: post._id,
    },
    count: 3,
  };

  const {RecommendationsList, PostsItemIntroSequence} = Components;
  return (
    <RecommendationsList
      algorithm={recommendationsAlgorithm}
      ListItem={({post, translucentBackground}: {
        post: PostsListWithVotesAndSequence,
        translucentBackground?: boolean,
      }) =>
        <PostsItemIntroSequence
          post={post}
          sequence={post.canonicalSequence ?? undefined}
          withImage={!!post.canonicalSequence?.gridImageId}
          translucentBackground={translucentBackground}
        />
      }
    />
  );
}

const PostsPageRecommendationsListComponent = registerComponent(
  "PostsPageRecommendationsList",
  PostsPageRecommendationsList,
);

declare global {
  interface ComponentTypes {
    PostsPageRecommendationsList: typeof PostsPageRecommendationsListComponent
  }
}