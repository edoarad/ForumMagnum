import { RecommendationFeatureName } from "../../lib/collections/users/recommendationSettings";

abstract class Feature {
  getJoin(): string {
    return "";
  }

  getFilter(): string {
    return "";
  }

  getScore(): string {
    return "";
  }

  getArgs(): Record<string, unknown> {
    return {};
  }
}

type ConstructableFeature = {
  new(): Feature;
}

class KarmaFeature extends Feature {
  private readonly pivot = 100;

  getScore() {
    return `
      CASE WHEN p."baseScore" > 0
        THEN p."baseScore" / (${this.pivot} + p."baseScore")
        ELSE 0
      END
    `;
  }
}

class CuratedFeature extends Feature {
  getScore() {
    return `CASE WHEN p."curatedDate" IS NULL THEN 0 ELSE 1 END`;
  }
}

class TagSimilarityFeature extends Feature {
  getScore() {
    return `fm_post_tag_similarity($(postId), p."_id")`;
  }
}

class CollabFilterFeature extends Feature {
  getJoin() {
    return `INNER JOIN "UniquePostUpvoters" rec ON rec."postId" = p."_id"`;
  }

  getScore() {
    const srcVoters = `(
      SELECT voters
      FROM "UniquePostUpvoters"
      WHERE "postId" = $(postId)
    )`;
    return `
      COALESCE(
        (# (${srcVoters} & rec.voters))::FLOAT /
          NULLIF((# (${srcVoters} | rec.voters))::FLOAT, 0),
        0
      )
    `;
  }
}

export const featureRegistry: Record<
  RecommendationFeatureName,
  ConstructableFeature
> = {
  karma: KarmaFeature,
  curated: CuratedFeature,
  tagSimilarity: TagSimilarityFeature,
  collabFilter: CollabFilterFeature,
};
