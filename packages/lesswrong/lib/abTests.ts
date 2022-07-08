import { ABTest, useABTest, useABTestProperties } from './abTestImpl';
export { useABTest, useABTestProperties };

// An A/B test which doesn't do anything (other than randomize you), for testing
// the A/B test infrastructure.
export const noEffectABTest = new ABTest({
  name: "abTestNoEffect",
  description: "A placeholder A/B test which has no effect",
  groups: {
    group1: {
      description: "The smaller test group",
      weight: 1,
    },
    group2: {
      description: "The larger test group",
      weight: 2,
    },
  }
});

// A/B test for the new CollectionsPage
export const collectionsPageABTest = new ABTest({
  name: "collectionsPageABTest",
  description: "Tests the new LargeSequencesItem on the CollectionsPage",
  groups: {
    originalLayoutGroup: {
      description: "Group with old layout (SequencesGridItem)",
      weight: 1,
    },
    largeSequenceItemGroup: {
      description: "Group using LargeSequencesItem",
      weight: 1,
    },
  }
});

// A/B test for the new BooksProgressBar
export const booksProgressBarABTest = new ABTest({
  name: "booksProgressBarABTest",
  description: "Tests the new BooksProgressBar, as used in BooksItem (itself used in CollectionsPage)",
  groups: {
    control: {
      description: "Original BooksItem without the progress bar",
      weight: 1
    },
    progressBar: {
      description: "Progress bar enabled",
      weight: 1
    }
  }
})