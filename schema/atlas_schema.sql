CREATE TABLE "AdvisorRequests" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "interestedInMetaculus" BOOL DEFAULT false ,
  "jobAds" JSONB ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_AdvisorRequests_schemaVersion" ON "AdvisorRequests" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_AdvisorRequests_userId" ON "AdvisorRequests" USING btree ( "userId" );

CREATE TABLE "Bans" (
  _id VARCHAR(27) PRIMARY KEY ,
  "expirationDate" TIMESTAMPTZ ,
  "userId" VARCHAR(27) ,
  "ip" TEXT ,
  "reason" TEXT ,
  "comment" TEXT ,
  "properties" JSONB ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Bans_schemaVersion" ON "Bans" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Bans_ip" ON "Bans" USING btree ( "ip" );

CREATE TABLE "Books" (
  _id VARCHAR(27) PRIMARY KEY ,
  "postedAt" TIMESTAMPTZ ,
  "title" TEXT ,
  "subtitle" TEXT ,
  "tocTitle" TEXT ,
  "collectionId" VARCHAR(27) NOT NULL ,
  "number" DOUBLE PRECISION ,
  "postIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "sequenceIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "displaySequencesAsGrid" BOOL ,
  "hideProgressBar" BOOL ,
  "showChapters" BOOL ,
  "contents" JSONB ,
  "contents_latest" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Books_schemaVersion" ON "Books" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Books_collectionId" ON "Books" USING btree ( "collectionId" );

CREATE TABLE "Chapters" (
  _id VARCHAR(27) PRIMARY KEY ,
  "title" TEXT ,
  "subtitle" TEXT ,
  "number" DOUBLE PRECISION ,
  "sequenceId" VARCHAR(27) ,
  "postIds" VARCHAR(27)[] NOT NULL DEFAULT '{}' ,
  "contents" JSONB ,
  "contents_latest" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Chapters_schemaVersion" ON "Chapters" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Chapters_sequenceId_number" ON "Chapters" USING btree ( "sequenceId" , "number" );

CREATE TABLE "ClientIds" (
  _id VARCHAR(27) PRIMARY KEY ,
  "clientId" TEXT ,
  "firstSeenReferrer" TEXT ,
  "firstSeenLandingPage" TEXT ,
  "userIds" TEXT[] DEFAULT '{}'::TEXT[] ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_ClientIds_schemaVersion" ON "ClientIds" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_ClientIds_clientId" ON "ClientIds" USING btree ( "clientId" );

CREATE INDEX IF NOT EXISTS "idx_ClientIds_userIds" ON "ClientIds" USING gin ( "userIds" );

CREATE TABLE "Collections" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "title" TEXT NOT NULL ,
  "slug" TEXT NOT NULL ,
  "gridImageId" TEXT ,
  "firstPageLink" TEXT ,
  "hideStartReadingButton" BOOL ,
  "contents" JSONB ,
  "contents_latest" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Collections_schemaVersion" ON "Collections" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Collections_slug" ON "Collections" USING btree ( "slug" );

CREATE TABLE "CommentModeratorActions" (
  _id VARCHAR(27) PRIMARY KEY ,
  "commentId" VARCHAR(27) ,
  "type" TEXT ,
  "endedAt" TIMESTAMPTZ ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_CommentModeratorActions_schemaVersion" ON "CommentModeratorActions" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_CommentModeratorActions_commentId_createdAt" ON "CommentModeratorActions" USING btree ( "commentId" , "createdAt" );

CREATE TABLE "Comments" (
  _id VARCHAR(27) PRIMARY KEY ,
  "parentCommentId" VARCHAR(27) ,
  "topLevelCommentId" VARCHAR(27) ,
  "postedAt" TIMESTAMPTZ ,
  "author" TEXT ,
  "postId" VARCHAR(27) ,
  "tagId" VARCHAR(27) ,
  "tagCommentType" TEXT DEFAULT 'DISCUSSION' ,
  "subforumStickyPriority" DOUBLE PRECISION ,
  "userId" VARCHAR(27) ,
  "userIP" TEXT ,
  "userAgent" TEXT ,
  "referrer" TEXT ,
  "authorIsUnreviewed" BOOL DEFAULT false ,
  "answer" BOOL DEFAULT false ,
  "parentAnswerId" VARCHAR(27) ,
  "directChildrenCount" DOUBLE PRECISION DEFAULT 0 ,
  "descendentCount" DOUBLE PRECISION DEFAULT 0 ,
  "shortform" BOOL ,
  "nominatedForReview" TEXT ,
  "reviewingForReview" TEXT ,
  "lastSubthreadActivity" TIMESTAMPTZ ,
  "postVersion" TEXT ,
  "promoted" BOOL ,
  "promotedByUserId" VARCHAR(27) ,
  "promotedAt" TIMESTAMPTZ ,
  "hideKarma" BOOL ,
  "legacy" BOOL DEFAULT false ,
  "legacyId" TEXT ,
  "legacyPoll" BOOL DEFAULT false ,
  "legacyParentId" TEXT ,
  "retracted" BOOL DEFAULT false ,
  "deleted" BOOL DEFAULT false ,
  "deletedPublic" BOOL DEFAULT false ,
  "deletedReason" TEXT ,
  "deletedDate" TIMESTAMPTZ ,
  "deletedByUserId" VARCHAR(27) ,
  "spam" BOOL DEFAULT false ,
  "repliesBlockedUntil" TIMESTAMPTZ ,
  "needsReview" BOOL ,
  "reviewedByUserId" VARCHAR(27) ,
  "hideAuthor" BOOL DEFAULT false ,
  "moderatorHat" BOOL DEFAULT false ,
  "hideModeratorHat" BOOL ,
  "isPinnedOnProfile" BOOL DEFAULT false ,
  "title" VARCHAR(500) ,
  "relevantTagIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "debateResponse" BOOL ,
  "af" BOOL DEFAULT false ,
  "suggestForAlignmentUserIds" TEXT[] DEFAULT '{}'::TEXT[] ,
  "reviewForAlignmentUserId" TEXT ,
  "afDate" TIMESTAMPTZ ,
  "moveToAlignmentUserId" VARCHAR(27) ,
  "agentFoundationsId" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "contents" JSONB ,
  "contents_latest" TEXT ,
  "pingbacks" JSONB ,
  "voteCount" DOUBLE PRECISION DEFAULT 0 ,
  "baseScore" DOUBLE PRECISION DEFAULT 0 ,
  "extendedScore" JSONB ,
  "score" DOUBLE PRECISION DEFAULT 0 ,
  "inactive" BOOL ,
  "afBaseScore" DOUBLE PRECISION ,
  "afExtendedScore" JSONB ,
  "afVoteCount" DOUBLE PRECISION 
);

CREATE INDEX IF NOT EXISTS "idx_Comments_schemaVersion" ON "Comments" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Comments_postId" ON "Comments" USING btree ( "postId" );

CREATE INDEX IF NOT EXISTS "idx_Comments_userId_postedAt" ON "Comments" USING btree ( "userId" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_Comments_parentCommentId" ON "Comments" USING btree ( "parentCommentId" );

CREATE INDEX IF NOT EXISTS "idx_comments_top_comments" ON "Comments" USING btree ( "postId" , "parentAnswerId" , "answer" , "deleted" , "baseScore" , "postedAt" , "authorIsUnreviewed" , "deletedPublic" , "hideAuthor" , "userId" , "af" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_comments_magic_comments" ON "Comments" USING btree ( "postId" , "parentAnswerId" , "answer" , "deleted" , "score" , "postedAt" , "authorIsUnreviewed" , "deletedPublic" , "hideAuthor" , "userId" , "af" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_comments_af_top_comments" ON "Comments" USING btree ( "postId" , "parentAnswerId" , "answer" , "deleted" , "afBaseScore" , "postedAt" , "authorIsUnreviewed" , "deletedPublic" , "hideAuthor" , "userId" , "af" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_comments_new_comments" ON "Comments" USING btree ( "postId" , "parentAnswerId" , "answer" , "deleted" , "postedAt" , "authorIsUnreviewed" , "deletedPublic" , "hideAuthor" , "userId" , "af" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_Comments_userId_isPinnedOnProfile_postedAt_authorIsUnreviewed_deleted_deletedPublic_hideAuthor_af_debateResponse" ON "Comments" USING btree ( "userId" , "isPinnedOnProfile" , "postedAt" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "af" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_Comments_postedAt_authorIsUnreviewed_deleted_deletedPublic_hideAuthor_userId_af_debateResponse" ON "Comments" USING btree ( "postedAt" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "userId" , "af" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_Comments_legacyId" ON "Comments" USING btree ( "legacyId" );

CREATE INDEX IF NOT EXISTS "idx_Comments_inactive_postedAt" ON "Comments" USING btree ( "inactive" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_Comments_userId_postedAt_authorIsUnreviewed_deleted_deletedPublic_hideAuthor_af_debateResponse" ON "Comments" USING btree ( "userId" , "postedAt" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "af" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_Comments_parentAnswerId_baseScore_authorIsUnreviewed_deleted_deletedPublic_hideAuthor_userId_af_postedAt_debateResponse" ON "Comments" USING btree ( "parentAnswerId" , "baseScore" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "userId" , "af" , "postedAt" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_Comments_topLevelCommentId" ON "Comments" USING btree ( "topLevelCommentId" );

CREATE INDEX IF NOT EXISTS "idx_Comments_agentFoundationsId" ON "Comments" USING btree ( "agentFoundationsId" );

CREATE INDEX IF NOT EXISTS "idx_Comments_shortform_topLevelCommentId_lastSubthreadActivity_postedAt_baseScore" ON "Comments" USING btree ( "shortform" , "topLevelCommentId" , "lastSubthreadActivity" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_Comments_topLevelCommentId_postedAt_baseScore" ON "Comments" USING btree ( "topLevelCommentId" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_comments_nominations2018" ON "Comments" USING btree ( "nominatedForReview" , "userId" , "postId" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "af" , "postedAt" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_comments_reviews2018" ON "Comments" USING btree ( "reviewingForReview" , "userId" , "postId" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "af" , "postedAt" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_comments_tagId" ON "Comments" USING btree ( "tagId" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "userId" , "af" , "postedAt" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_Comments_topLevelCommentId_tagCommentType_tagId_authorIsUnreviewed_deleted_deletedPublic_hideAuthor_userId_af_postedAt_debateResponse" ON "Comments" USING btree ( "topLevelCommentId" , "tagCommentType" , "tagId" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "userId" , "af" , "postedAt" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_comments_moderatorHat" ON "Comments" USING btree ( "moderatorHat" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "userId" , "af" , "postedAt" , "debateResponse" );

CREATE INDEX IF NOT EXISTS "idx_comments_alignmentSuggestedComments" ON "Comments" USING gin ( "reviewForAlignmentUserId" , "af" , "suggestForAlignmentUserIds" , "postedAt" , "authorIsUnreviewed" , "deleted" , "deletedPublic" , "hideAuthor" , "userId" , "debateResponse" ) WHERE ("suggestForAlignmentUserIds"[0]) IS NOT NULL;

CREATE INDEX IF NOT EXISTS "idx_Comments_userId_createdAt" ON "Comments" USING btree ( "userId" , "createdAt" );

CREATE TABLE "Conversations" (
  _id VARCHAR(27) PRIMARY KEY ,
  "title" TEXT ,
  "participantIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "latestActivity" TIMESTAMPTZ ,
  "af" BOOL ,
  "messageCount" DOUBLE PRECISION DEFAULT 0 ,
  "moderator" BOOL ,
  "archivedByIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Conversations_schemaVersion" ON "Conversations" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Conversations_moderator_messageCount_latestActivity_participantIds" ON "Conversations" USING gin ( "moderator" , "messageCount" , "latestActivity" , "participantIds" );

CREATE INDEX IF NOT EXISTS "idx_Conversations_participantIds_messageCount_latestActivity" ON "Conversations" USING gin ( "participantIds" , "messageCount" , "latestActivity" );

CREATE INDEX IF NOT EXISTS "idx_Conversations_participantIds_title" ON "Conversations" USING gin ( "participantIds" , "title" );

CREATE TABLE "CronHistories" (
  _id VARCHAR(27) PRIMARY KEY ,
  "intendedAt" TIMESTAMPTZ NOT NULL ,
  "name" TEXT NOT NULL ,
  "startedAt" TIMESTAMPTZ NOT NULL ,
  "finishedAt" TIMESTAMPTZ ,
  "result" JSONB 
);

CREATE UNIQUE INDEX IF NOT EXISTS "idx_CronHistories_intendedAt_name" ON "CronHistories" USING btree ( "intendedAt" , "name" );

CREATE INDEX IF NOT EXISTS "idx_CronHistories_startedAt" ON "CronHistories" USING btree ( "startedAt" );

CREATE TABLE "DatabaseMetadata" (
  _id VARCHAR(27) PRIMARY KEY ,
  "name" TEXT ,
  "value" JSONB ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_DatabaseMetadata_schemaVersion" ON "DatabaseMetadata" USING btree ( "schemaVersion" );

CREATE UNIQUE INDEX IF NOT EXISTS "idx_DatabaseMetadata_name" ON "DatabaseMetadata" USING btree ( COALESCE("name", '') );

CREATE UNIQUE INDEX IF NOT EXISTS "idx_DatabaseMetadata_name" ON "DatabaseMetadata" USING btree ( COALESCE("name", '') );

CREATE TABLE "DebouncerEvents" (
  _id VARCHAR(27) PRIMARY KEY ,
  "name" TEXT ,
  "af" BOOL ,
  "dispatched" BOOL ,
  "failed" BOOL ,
  "delayTime" TIMESTAMPTZ ,
  "upperBoundTime" TIMESTAMPTZ ,
  "key" TEXT ,
  "pendingEvents" TEXT[] ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_DebouncerEvents_schemaVersion" ON "DebouncerEvents" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_DebouncerEvents_dispatched_af_delayTime" ON "DebouncerEvents" USING btree ( "dispatched" , "af" , "delayTime" );

CREATE INDEX IF NOT EXISTS "idx_DebouncerEvents_dispatched_af_upperBoundTime" ON "DebouncerEvents" USING btree ( "dispatched" , "af" , "upperBoundTime" );

CREATE UNIQUE INDEX IF NOT EXISTS "idx_DebouncerEvents_dispatched_af_key_name_filtered" ON "DebouncerEvents" USING btree ( "dispatched" , "af" , COALESCE("key", '') , COALESCE("name", '') ) WHERE "dispatched" IS FALSE;

CREATE TABLE "EmailTokens" (
  _id VARCHAR(27) PRIMARY KEY ,
  "token" TEXT ,
  "tokenType" TEXT ,
  "userId" VARCHAR(27) ,
  "usedAt" TIMESTAMPTZ ,
  "params" JSONB ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_EmailTokens_schemaVersion" ON "EmailTokens" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_EmailTokens_token" ON "EmailTokens" USING btree ( "token" );

CREATE TABLE "FeaturedResources" (
  _id VARCHAR(27) PRIMARY KEY ,
  "title" TEXT ,
  "body" TEXT ,
  "ctaText" TEXT ,
  "ctaUrl" TEXT ,
  "expiresAt" TIMESTAMPTZ ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_FeaturedResources_schemaVersion" ON "FeaturedResources" USING btree ( "schemaVersion" );

CREATE TABLE "GardenCodes" (
  _id VARCHAR(27) PRIMARY KEY ,
  "code" TEXT ,
  "title" TEXT DEFAULT 'Guest Day Pass' ,
  "userId" VARCHAR(27) ,
  "slug" TEXT ,
  "startTime" TIMESTAMPTZ ,
  "endTime" TIMESTAMPTZ ,
  "fbLink" TEXT ,
  "type" TEXT DEFAULT 'public' ,
  "hidden" BOOL DEFAULT false ,
  "deleted" BOOL DEFAULT false ,
  "afOnly" BOOL DEFAULT false ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "contents" JSONB ,
  "contents_latest" TEXT ,
  "pingbacks" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_GardenCodes_schemaVersion" ON "GardenCodes" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_GardenCodes_code_deleted" ON "GardenCodes" USING btree ( "code" , "deleted" );

CREATE INDEX IF NOT EXISTS "idx_GardenCodes_userId_deleted" ON "GardenCodes" USING btree ( "userId" , "deleted" );

CREATE INDEX IF NOT EXISTS "idx_GardenCodes_code_deleted_userId" ON "GardenCodes" USING btree ( "code" , "deleted" , "userId" );

CREATE INDEX IF NOT EXISTS "idx_GardenCodes_code_deleted_userId" ON "GardenCodes" USING btree ( "code" , "deleted" , "userId" );

CREATE TABLE "Images" (
  _id VARCHAR(27) PRIMARY KEY ,
  "originalUrl" TEXT ,
  "cdnHostedUrl" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Images_schemaVersion" ON "Images" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Images_originalUrl" ON "Images" USING btree ( "originalUrl" );

CREATE INDEX IF NOT EXISTS "idx_Images_cdnHostedUrl" ON "Images" USING btree ( "cdnHostedUrl" );

CREATE TABLE "LWEvents" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "name" TEXT ,
  "documentId" TEXT ,
  "important" BOOL ,
  "properties" JSONB ,
  "intercom" BOOL ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_LWEvents_schemaVersion" ON "LWEvents" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_LWEvents_name_createdAt" ON "LWEvents" USING btree ( "name" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_LWEvents_name_userId_documentId_createdAt" ON "LWEvents" USING btree ( "name" , "userId" , "documentId" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_LWEvents_name_userId_createdAt" ON "LWEvents" USING btree ( "name" , "userId" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_LWEvents_name_properties__ip_createdAt_userId" ON "LWEvents" USING gin ( "name" , ("properties"->'ip') , "createdAt" , "userId" );

CREATE TABLE "LegacyData" (
  _id VARCHAR(27) PRIMARY KEY ,
  "objectId" TEXT ,
  "collectionName" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_LegacyData_schemaVersion" ON "LegacyData" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_LegacyData_objectId" ON "LegacyData" USING btree ( "objectId" );

CREATE TABLE "Localgroups" (
  _id VARCHAR(27) PRIMARY KEY ,
  "name" TEXT ,
  "nameInAnotherLanguage" TEXT ,
  "organizerIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "lastActivity" TIMESTAMPTZ ,
  "types" TEXT[] DEFAULT '{''LW''}'::TEXT[] ,
  "categories" TEXT[] ,
  "isOnline" BOOL DEFAULT false ,
  "mongoLocation" JSONB ,
  "googleLocation" JSONB ,
  "location" TEXT ,
  "contactInfo" TEXT ,
  "facebookLink" TEXT ,
  "facebookPageLink" TEXT ,
  "meetupLink" TEXT ,
  "slackLink" TEXT ,
  "website" TEXT ,
  "bannerImageId" TEXT ,
  "inactive" BOOL DEFAULT false ,
  "deleted" BOOL DEFAULT false ,
  "salesforceId" TEXT ,
  "contents" JSONB ,
  "contents_latest" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Localgroups_schemaVersion" ON "Localgroups" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Localgroups_organizerIds_deleted_name" ON "Localgroups" USING gin ( "organizerIds" , "deleted" , "name" );

CREATE INDEX IF NOT EXISTS "idx_Localgroups_organizerIds_inactive_deleted_name" ON "Localgroups" USING gin ( "organizerIds" , "inactive" , "deleted" , "name" );

CREATE INDEX IF NOT EXISTS "idx_Localgroups_organizerIds_inactive_deleted" ON "Localgroups" USING gin ( "organizerIds" , "inactive" , "deleted" );

CREATE INDEX IF NOT EXISTS "idx_Localgroups_inactive_deleted_name" ON "Localgroups" USING btree ( "inactive" , "deleted" , "name" );

CREATE INDEX IF NOT EXISTS "idx_Localgroups_mongoLocation_isOnline_inactive_deleted" ON "Localgroups" USING btree ( "mongoLocation" , "isOnline" , "inactive" , "deleted" );

CREATE INDEX IF NOT EXISTS "idx_Localgroups_isOnline_inactive_deleted_name" ON "Localgroups" USING btree ( "isOnline" , "inactive" , "deleted" , "name" );

CREATE TABLE "Messages" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "conversationId" VARCHAR(27) ,
  "noEmail" BOOL DEFAULT false ,
  "contents" JSONB ,
  "contents_latest" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Messages_schemaVersion" ON "Messages" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Messages_conversationId_createdAt" ON "Messages" USING btree ( "conversationId" , "createdAt" );

CREATE TABLE "Migrations" (
  _id VARCHAR(27) PRIMARY KEY ,
  "name" TEXT ,
  "started" TIMESTAMPTZ ,
  "finished" BOOL DEFAULT false ,
  "succeeded" BOOL DEFAULT false ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Migrations_schemaVersion" ON "Migrations" USING btree ( "schemaVersion" );

CREATE TABLE "ModerationTemplates" (
  _id VARCHAR(27) PRIMARY KEY ,
  "name" TEXT ,
  "collectionName" TEXT ,
  "order" DOUBLE PRECISION DEFAULT 0 ,
  "deleted" BOOL DEFAULT false ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "contents" JSONB ,
  "contents_latest" TEXT 
);

CREATE INDEX IF NOT EXISTS "idx_ModerationTemplates_schemaVersion" ON "ModerationTemplates" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_ModerationTemplates_order" ON "ModerationTemplates" USING btree ( "order" );

CREATE TABLE "ModeratorActions" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "type" TEXT ,
  "endedAt" TIMESTAMPTZ ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_ModeratorActions_schemaVersion" ON "ModeratorActions" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_ModeratorActions_userId_createdAt" ON "ModeratorActions" USING btree ( "userId" , "createdAt" );

CREATE TABLE "Notifications" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "documentId" TEXT ,
  "documentType" TEXT ,
  "extraData" JSONB ,
  "link" TEXT ,
  "title" TEXT ,
  "message" TEXT ,
  "type" TEXT ,
  "deleted" BOOL DEFAULT false ,
  "viewed" BOOL DEFAULT false ,
  "emailed" BOOL DEFAULT false ,
  "waitingForBatch" BOOL DEFAULT false ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Notifications_schemaVersion" ON "Notifications" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Notifications_userId_emailed_waitingForBatch_createdAt_type" ON "Notifications" USING btree ( "userId" , "emailed" , "waitingForBatch" , "createdAt" , "type" );

CREATE INDEX IF NOT EXISTS "idx_Notifications_userId_type_createdAt" ON "Notifications" USING btree ( "userId" , "type" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Notifications_documentId" ON "Notifications" USING btree ( "documentId" );

CREATE TABLE "PetrovDayLaunchs" (
  _id VARCHAR(27) PRIMARY KEY ,
  "launchCode" TEXT ,
  "hashedLaunchCode" TEXT ,
  "userId" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_PetrovDayLaunchs_schemaVersion" ON "PetrovDayLaunchs" USING btree ( "schemaVersion" );

CREATE TABLE "PodcastEpisodes" (
  _id VARCHAR(27) PRIMARY KEY ,
  "podcastId" VARCHAR(27) ,
  "title" TEXT NOT NULL ,
  "episodeLink" TEXT NOT NULL ,
  "externalEpisodeId" TEXT NOT NULL ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_PodcastEpisodes_schemaVersion" ON "PodcastEpisodes" USING btree ( "schemaVersion" );

CREATE UNIQUE INDEX IF NOT EXISTS "idx_PodcastEpisodes_externalEpisodeId" ON "PodcastEpisodes" USING btree ( "externalEpisodeId" );

CREATE TABLE "Podcasts" (
  _id VARCHAR(27) PRIMARY KEY ,
  "title" TEXT NOT NULL ,
  "applePodcastLink" TEXT ,
  "spotifyPodcastLink" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Podcasts_schemaVersion" ON "Podcasts" USING btree ( "schemaVersion" );

CREATE TABLE "PostRelations" (
  _id VARCHAR(27) PRIMARY KEY ,
  "type" TEXT ,
  "sourcePostId" VARCHAR(27) ,
  "targetPostId" VARCHAR(27) ,
  "order" DOUBLE PRECISION ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_PostRelations_schemaVersion" ON "PostRelations" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_PostRelations_sourcePostId_order_createdAt" ON "PostRelations" USING btree ( "sourcePostId" , "order" , "createdAt" );

CREATE TABLE "Posts" (
  _id VARCHAR(27) PRIMARY KEY ,
  "postedAt" TIMESTAMPTZ ,
  "modifiedAt" TIMESTAMPTZ ,
  "url" VARCHAR(500) ,
  "title" VARCHAR(500) NOT NULL ,
  "slug" TEXT ,
  "viewCount" DOUBLE PRECISION DEFAULT 0 ,
  "lastCommentedAt" TIMESTAMPTZ ,
  "clickCount" DOUBLE PRECISION DEFAULT 0 ,
  "deletedDraft" BOOL DEFAULT false ,
  "status" DOUBLE PRECISION ,
  "isFuture" BOOL ,
  "sticky" BOOL DEFAULT false ,
  "stickyPriority" INTEGER DEFAULT 2 ,
  "userIP" TEXT ,
  "userAgent" TEXT ,
  "referrer" TEXT ,
  "author" TEXT ,
  "userId" VARCHAR(27) ,
  "question" BOOL DEFAULT false ,
  "authorIsUnreviewed" BOOL DEFAULT false ,
  "readTimeMinutesOverride" DOUBLE PRECISION ,
  "submitToFrontpage" BOOL DEFAULT true ,
  "hiddenRelatedQuestion" BOOL DEFAULT false ,
  "originalPostRelationSourceId" TEXT ,
  "shortform" BOOL DEFAULT false ,
  "canonicalSource" TEXT ,
  "nominationCount2018" DOUBLE PRECISION DEFAULT 0 ,
  "nominationCount2019" DOUBLE PRECISION DEFAULT 0 ,
  "reviewCount2018" DOUBLE PRECISION DEFAULT 0 ,
  "reviewCount2019" DOUBLE PRECISION DEFAULT 0 ,
  "reviewCount" DOUBLE PRECISION DEFAULT 0 ,
  "reviewVoteCount" DOUBLE PRECISION DEFAULT 0 ,
  "positiveReviewVoteCount" DOUBLE PRECISION DEFAULT 0 ,
  "reviewVoteScoreAF" DOUBLE PRECISION DEFAULT 0 ,
  "reviewVotesAF" DOUBLE PRECISION[] DEFAULT '{}'::DOUBLE PRECISION[] ,
  "reviewVoteScoreHighKarma" DOUBLE PRECISION DEFAULT 0 ,
  "reviewVotesHighKarma" DOUBLE PRECISION[] DEFAULT '{}'::DOUBLE PRECISION[] ,
  "reviewVoteScoreAllKarma" DOUBLE PRECISION DEFAULT 0 ,
  "reviewVotesAllKarma" DOUBLE PRECISION[] DEFAULT '{}'::DOUBLE PRECISION[] ,
  "finalReviewVoteScoreHighKarma" DOUBLE PRECISION DEFAULT 0 ,
  "finalReviewVotesHighKarma" DOUBLE PRECISION[] DEFAULT '{}'::DOUBLE PRECISION[] ,
  "finalReviewVoteScoreAllKarma" DOUBLE PRECISION DEFAULT 0 ,
  "finalReviewVotesAllKarma" DOUBLE PRECISION[] DEFAULT '{}'::DOUBLE PRECISION[] ,
  "finalReviewVoteScoreAF" DOUBLE PRECISION DEFAULT 0 ,
  "finalReviewVotesAF" DOUBLE PRECISION[] DEFAULT '{}'::DOUBLE PRECISION[] ,
  "lastCommentPromotedAt" TIMESTAMPTZ ,
  "tagRelevance" JSONB ,
  "noIndex" BOOL DEFAULT false ,
  "rsvps" JSONB[] ,
  "activateRSVPs" BOOL ,
  "nextDayReminderSent" BOOL DEFAULT false ,
  "onlyVisibleToLoggedIn" BOOL DEFAULT false ,
  "onlyVisibleToEstablishedAccounts" BOOL DEFAULT false ,
  "hideFromRecentDiscussions" BOOL DEFAULT false ,
  "votingSystem" TEXT DEFAULT 'twoAxis' ,
  "podcastEpisodeId" VARCHAR(27) ,
  "legacy" BOOL DEFAULT false ,
  "legacyId" TEXT ,
  "legacySpam" BOOL DEFAULT false ,
  "feedId" VARCHAR(27) ,
  "feedLink" TEXT ,
  "curatedDate" TIMESTAMPTZ ,
  "metaDate" TIMESTAMPTZ ,
  "suggestForCuratedUserIds" VARCHAR(27)[] ,
  "frontpageDate" TIMESTAMPTZ ,
  "collectionTitle" TEXT ,
  "coauthorStatuses" JSONB[] ,
  "hasCoauthorPermission" BOOL DEFAULT true ,
  "socialPreviewImageId" TEXT ,
  "socialPreviewImageAutoUrl" TEXT ,
  "fmCrosspost" JSONB DEFAULT '{"isCrosspost":false}'::JSONB ,
  "canonicalSequenceId" VARCHAR(27) ,
  "canonicalCollectionSlug" TEXT ,
  "canonicalBookId" VARCHAR(27) ,
  "canonicalNextPostSlug" TEXT ,
  "canonicalPrevPostSlug" TEXT ,
  "unlisted" BOOL DEFAULT false ,
  "disableRecommendation" BOOL DEFAULT false ,
  "defaultRecommendation" BOOL DEFAULT false ,
  "draft" BOOL DEFAULT false ,
  "meta" BOOL DEFAULT false ,
  "hideFrontpageComments" BOOL DEFAULT false ,
  "maxBaseScore" DOUBLE PRECISION ,
  "scoreExceeded2Date" TIMESTAMPTZ ,
  "scoreExceeded30Date" TIMESTAMPTZ ,
  "scoreExceeded45Date" TIMESTAMPTZ ,
  "scoreExceeded75Date" TIMESTAMPTZ ,
  "scoreExceeded125Date" TIMESTAMPTZ ,
  "scoreExceeded200Date" TIMESTAMPTZ ,
  "bannedUserIds" VARCHAR(27)[] ,
  "commentsLocked" BOOL ,
  "commentsLockedToAccountsCreatedAfter" TIMESTAMPTZ ,
  "organizerIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "groupId" VARCHAR(27) ,
  "eventType" TEXT ,
  "isEvent" BOOL DEFAULT false ,
  "reviewedByUserId" VARCHAR(27) ,
  "reviewForCuratedUserId" VARCHAR(27) ,
  "startTime" TIMESTAMPTZ ,
  "localStartTime" TIMESTAMPTZ ,
  "endTime" TIMESTAMPTZ ,
  "localEndTime" TIMESTAMPTZ ,
  "eventRegistrationLink" TEXT ,
  "joinEventLink" TEXT ,
  "onlineEvent" BOOL DEFAULT false ,
  "globalEvent" BOOL DEFAULT false ,
  "mongoLocation" JSONB ,
  "googleLocation" JSONB ,
  "location" TEXT ,
  "contactInfo" TEXT ,
  "facebookLink" TEXT ,
  "meetupLink" TEXT ,
  "website" TEXT ,
  "eventImageId" TEXT ,
  "types" TEXT[] ,
  "metaSticky" BOOL DEFAULT false ,
  "sharingSettings" JSONB ,
  "shareWithUsers" VARCHAR(27)[] ,
  "linkSharingKey" TEXT ,
  "linkSharingKeyUsedBy" VARCHAR(27)[] ,
  "commentSortOrder" TEXT ,
  "hideAuthor" BOOL DEFAULT false ,
  "sideCommentsCache" JSONB ,
  "sideCommentVisibility" TEXT ,
  "moderationStyle" TEXT ,
  "hideCommentKarma" BOOL DEFAULT false ,
  "commentCount" DOUBLE PRECISION DEFAULT 0 ,
  "debate" BOOL DEFAULT false ,
  "subforumTagId" VARCHAR(27) ,
  "af" BOOL DEFAULT false ,
  "afDate" TIMESTAMPTZ ,
  "afCommentCount" DOUBLE PRECISION DEFAULT 0 ,
  "afLastCommentedAt" TIMESTAMPTZ ,
  "afSticky" BOOL DEFAULT false ,
  "suggestForAlignmentUserIds" TEXT[] DEFAULT '{}'::TEXT[] ,
  "reviewForAlignmentUserId" TEXT ,
  "agentFoundationsId" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "contents" JSONB ,
  "contents_latest" TEXT ,
  "pingbacks" JSONB ,
  "moderationGuidelines" JSONB ,
  "moderationGuidelines_latest" TEXT ,
  "customHighlight" JSONB ,
  "customHighlight_latest" TEXT ,
  "voteCount" DOUBLE PRECISION DEFAULT 0 ,
  "baseScore" DOUBLE PRECISION DEFAULT 0 ,
  "extendedScore" JSONB ,
  "score" DOUBLE PRECISION DEFAULT 0 ,
  "inactive" BOOL ,
  "afBaseScore" DOUBLE PRECISION ,
  "afExtendedScore" JSONB ,
  "afVoteCount" DOUBLE PRECISION 
);

CREATE INDEX IF NOT EXISTS "idx_Posts_schemaVersion" ON "Posts" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_posts_coauthorStatuses_postedAt" ON "Posts" USING gin ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "coauthorStatuses" , "userId" , "postedAt" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_score" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "score" , "isEvent" , "_id" , "meta" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_Posts_tagRelevance__$**" ON "Posts" USING gin ( ("tagRelevance"->'$**') );

CREATE INDEX IF NOT EXISTS "idx_posts_sort_by_topAdjusted" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "postedAt" , "baseScore" , "maxBaseScore" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" ) WHERE ( "status" =  2 AND "draft" IS FALSE AND "unlisted" IS FALSE AND "isFuture" IS FALSE AND "shortform" IS FALSE AND "authorIsUnreviewed" IS FALSE AND "hiddenRelatedQuestion" IS FALSE AND "isEvent" IS FALSE );

CREATE INDEX IF NOT EXISTS "idx_posts_postedAt_baseScore" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "postedAt" , "baseScore" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" );

CREATE INDEX IF NOT EXISTS "idx_posts_postedAt_baseScore" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "postedAt" , "baseScore" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" );

CREATE INDEX IF NOT EXISTS "idx_posts_frontpage" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "sticky" , "stickyPriority" , "score" , "frontpageDate" , "_id" , "meta" , "isEvent" , "af" , "curatedDate" , "postedAt" , "baseScore" ) WHERE "frontpageDate" >  '1970-01-01T01:00:00.000+01:00';

CREATE INDEX IF NOT EXISTS "idx_posts_curated" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "sticky" , "curatedDate" , "postedAt" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "baseScore" ) WHERE "curatedDate" >  '1970-01-01T01:00:00.000+01:00';

CREATE INDEX IF NOT EXISTS "idx_posts_community" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "sticky" , "score" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_topQuestions" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "question" , "lastCommentedAt" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_userId_createdAt" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "userId" , "hideAuthor" , "deletedDraft" , "modifiedAt" , "createdAt" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_userId_shareWithUsers" ON "Posts" USING gin ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "shareWithUsers" , "deletedDraft" , "modifiedAt" , "createdAt" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_Posts_slug" ON "Posts" USING btree ( "slug" );

CREATE INDEX IF NOT EXISTS "idx_Posts_legacyId" ON "Posts" USING btree ( "legacyId" );

CREATE INDEX IF NOT EXISTS "idx_Posts_status_isFuture_draft_unlisted_authorIsUnreviewed_hideFrontpageComments_lastCommentedAt__id_baseScore_af_isEvent_globalEvent_commentCount" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "authorIsUnreviewed" , "hideFrontpageComments" , "lastCommentedAt" , "_id" , "baseScore" , "af" , "isEvent" , "globalEvent" , "commentCount" );

CREATE INDEX IF NOT EXISTS "idx_posts_recentDiscussionThreadsList" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "lastCommentedAt" , "baseScore" , "hideFrontpageComments" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_posts_globalEvents" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "globalEvent" , "eventType" , "startTime" , "endTime" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_2dsphere" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "mongoLocation" , "eventType" , "startTime" , "endTime" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_events" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "globalEvent" , "onlineEvent" , "startTime" , "endTime" , "createdAt" , "baseScore" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_posts_postsWithBannedUsers" ON "Posts" USING gin ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "bannedUserIds" , "createdAt" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_sunshineNewPosts" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "reviewedByUserId" , "frontpageDate" , "meta" , "_id" , "isEvent" , "af" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_sunshineNewUsersPosts" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "userId" , "hideAuthor" , "reviewedByUserId" , "frontpageDate" , "createdAt" , "_id" , "meta" , "isEvent" , "af" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_sunshineCuratedSuggestions" ON "Posts" USING gin ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "createdAt" , "reviewForCuratedUserId" , "suggestForCuratedUserIds" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" ) WHERE "suggestForCuratedUserIds" IS NOT NULL;

CREATE INDEX IF NOT EXISTS "idx_Posts_userId_createdAt" ON "Posts" USING btree ( "userId" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Posts_agentFoundationsId" ON "Posts" USING btree ( "agentFoundationsId" );

CREATE INDEX IF NOT EXISTS "idx_Posts_isFuture_postedAt" ON "Posts" USING btree ( "isFuture" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_Posts_inactive_postedAt" ON "Posts" USING btree ( "inactive" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_posts_recommendable" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "meta" , "disableRecommendation" , "baseScore" , "curatedDate" , "frontpageDate" , "_id" , "isEvent" , "af" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_posts_pingbackPosts" ON "Posts" USING gin ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , ("pingbacks"->'Posts') , "baseScore" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_posts_nominatablePostsByVote" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "_id" , "userId" , "isEvent" , "baseScore" , "meta" , "af" , "frontpageDate" , "curatedDate" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_posts_positiveReviewVoteCount" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "positiveReviewVoteCount" , "createdAt" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_positiveReviewVoteCountReviewCount" ON "Posts" USING btree ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "positiveReviewVoteCount" , "reviewCount" , "createdAt" , "_id" , "meta" , "isEvent" , "af" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" );

CREATE INDEX IF NOT EXISTS "idx_posts_alignmentSuggestedPosts" ON "Posts" USING gin ( "status" , "isFuture" , "draft" , "unlisted" , "shortform" , "hiddenRelatedQuestion" , "authorIsUnreviewed" , "groupId" , "reviewForAlignmentUserId" , "af" , "suggestForAlignmentUserIds" , "createdAt" , "_id" , "meta" , "isEvent" , "frontpageDate" , "curatedDate" , "postedAt" , "baseScore" ) WHERE ("suggestForAlignmentUserIds"[0]) IS NOT NULL;

CREATE INDEX IF NOT EXISTS "idx_Posts_url_postedAt" ON "Posts" USING btree ( "url" , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_Posts_fmCrosspost__foreignPostId_postedAt" ON "Posts" USING gin ( ("fmCrosspost"->'foreignPostId') , "postedAt" );

CREATE INDEX IF NOT EXISTS "idx_Posts_defaultRecommendation" ON "Posts" USING btree ( "defaultRecommendation" );

CREATE TABLE "RSSFeeds" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "ownedByUser" BOOL DEFAULT false ,
  "displayFullContent" BOOL DEFAULT false ,
  "nickname" TEXT ,
  "url" TEXT ,
  "status" TEXT ,
  "rawFeed" JSONB ,
  "setCanonicalUrl" BOOL DEFAULT false ,
  "importAsDraft" BOOL DEFAULT false ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_RSSFeeds_schemaVersion" ON "RSSFeeds" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_RSSFeeds_userId_createdAt" ON "RSSFeeds" USING btree ( "userId" , "createdAt" );

CREATE TABLE "ReadStatuses" (
  _id VARCHAR(27) PRIMARY KEY ,
  "postId" VARCHAR(27) ,
  "tagId" VARCHAR(27) ,
  "userId" VARCHAR(27) ,
  "isRead" BOOL ,
  "lastUpdated" TIMESTAMPTZ ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_ReadStatuses_schemaVersion" ON "ReadStatuses" USING btree ( "schemaVersion" );

CREATE UNIQUE INDEX IF NOT EXISTS "idx_ReadStatuses_userId_postId_tagId" ON "ReadStatuses" USING btree ( COALESCE("userId", '') , COALESCE("postId", '') , COALESCE("tagId", '') );

CREATE INDEX IF NOT EXISTS "idx_ReadStatuses_userId_postId_isRead_lastUpdated" ON "ReadStatuses" USING btree ( "userId" , "postId" , "isRead" , "lastUpdated" );

CREATE INDEX IF NOT EXISTS "idx_ReadStatuses_userId_tagId_isRead_lastUpdated" ON "ReadStatuses" USING btree ( "userId" , "tagId" , "isRead" , "lastUpdated" );

CREATE TABLE "Reports" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "reportedUserId" VARCHAR(27) ,
  "commentId" VARCHAR(27) ,
  "postId" VARCHAR(27) ,
  "link" TEXT NOT NULL ,
  "claimedUserId" VARCHAR(27) ,
  "description" TEXT ,
  "closedAt" TIMESTAMPTZ ,
  "markedAsSpam" BOOL ,
  "reportedAsSpam" BOOL ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Reports_schemaVersion" ON "Reports" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Reports_createdAt" ON "Reports" USING btree ( "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Reports_claimedUserId_createdAt" ON "Reports" USING btree ( "claimedUserId" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Reports_closedAt_createdAt" ON "Reports" USING btree ( "closedAt" , "createdAt" );

CREATE TABLE "ReviewVotes" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "postId" VARCHAR(27) ,
  "qualitativeScore" INTEGER DEFAULT 4 ,
  "quadraticScore" INTEGER DEFAULT 0 ,
  "comment" TEXT ,
  "year" TEXT DEFAULT '2018' ,
  "dummy" BOOL DEFAULT false ,
  "reactions" TEXT[] ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_ReviewVotes_schemaVersion" ON "ReviewVotes" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_ReviewVotes_year_userId_dummy" ON "ReviewVotes" USING btree ( "year" , "userId" , "dummy" );

CREATE INDEX IF NOT EXISTS "idx_ReviewVotes_postId" ON "ReviewVotes" USING btree ( "postId" );

CREATE INDEX IF NOT EXISTS "idx_ReviewVotes_postId_userId" ON "ReviewVotes" USING btree ( "postId" , "userId" );

CREATE INDEX IF NOT EXISTS "idx_ReviewVotes_year_dummy_createdAt" ON "ReviewVotes" USING btree ( "year" , "dummy" , "createdAt" );

CREATE TABLE "Revisions" (
  _id VARCHAR(27) PRIMARY KEY ,
  "documentId" TEXT ,
  "collectionName" TEXT ,
  "fieldName" TEXT ,
  "editedAt" TIMESTAMPTZ ,
  "autosaveTimeoutStart" TIMESTAMPTZ ,
  "updateType" TEXT ,
  "version" TEXT ,
  "commitMessage" TEXT ,
  "userId" VARCHAR(27) ,
  "draft" BOOL ,
  "originalContents" JSONB ,
  "html" TEXT ,
  "wordCount" DOUBLE PRECISION ,
  "changeMetrics" JSONB ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "voteCount" DOUBLE PRECISION DEFAULT 0 ,
  "baseScore" DOUBLE PRECISION DEFAULT 0 ,
  "extendedScore" JSONB ,
  "score" DOUBLE PRECISION DEFAULT 0 ,
  "inactive" BOOL ,
  "afBaseScore" DOUBLE PRECISION ,
  "afExtendedScore" JSONB ,
  "afVoteCount" DOUBLE PRECISION 
);

CREATE INDEX IF NOT EXISTS "idx_Revisions_schemaVersion" ON "Revisions" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Revisions_userId_collectionName_editedAt" ON "Revisions" USING btree ( "userId" , "collectionName" , "editedAt" );

CREATE INDEX IF NOT EXISTS "idx_Revisions_collectionName_fieldName_editedAt__id_changeMetrics" ON "Revisions" USING btree ( "collectionName" , "fieldName" , "editedAt" , "_id" , "changeMetrics" );

CREATE INDEX IF NOT EXISTS "idx_Revisions_documentId_version_fieldName_editedAt" ON "Revisions" USING btree ( "documentId" , "version" , "fieldName" , "editedAt" );

CREATE TABLE "Sequences" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "title" TEXT NOT NULL ,
  "gridImageId" TEXT ,
  "bannerImageId" TEXT ,
  "curatedOrder" DOUBLE PRECISION ,
  "userProfileOrder" DOUBLE PRECISION ,
  "draft" BOOL DEFAULT false ,
  "isDeleted" BOOL DEFAULT false ,
  "canonicalCollectionSlug" TEXT ,
  "hidden" BOOL DEFAULT false ,
  "hideFromAuthorPage" BOOL DEFAULT false ,
  "af" BOOL DEFAULT false ,
  "contents" JSONB ,
  "contents_latest" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Sequences_schemaVersion" ON "Sequences" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Sequences_hidden_af_isDeleted_userId_userProfileOrder" ON "Sequences" USING btree ( "hidden" , "af" , "isDeleted" , "userId" , "userProfileOrder" );

CREATE INDEX IF NOT EXISTS "idx_Sequences_hidden_af_isDeleted_userId_draft_hideFromAuthorPage_userProfileOrder" ON "Sequences" USING btree ( "hidden" , "af" , "isDeleted" , "userId" , "draft" , "hideFromAuthorPage" , "userProfileOrder" );

CREATE INDEX IF NOT EXISTS "idx_Sequences_hidden_af_isDeleted_curatedOrder" ON "Sequences" USING btree ( "hidden" , "af" , "isDeleted" , "curatedOrder" );

CREATE TABLE "Sessions" (
  _id TEXT NOT NULL PRIMARY KEY ,
  "session" JSONB ,
  "expires" TIMESTAMPTZ ,
  "lastModified" TIMESTAMPTZ 
);

CREATE INDEX IF NOT EXISTS "idx_Sessions_expires" ON "Sessions" USING btree ( "expires" );

CREATE TABLE "Spotlights" (
  _id VARCHAR(27) PRIMARY KEY ,
  "documentId" TEXT ,
  "documentType" TEXT DEFAULT 'Sequence' ,
  "position" DOUBLE PRECISION ,
  "duration" DOUBLE PRECISION DEFAULT 3 ,
  "customTitle" TEXT ,
  "customSubtitle" TEXT ,
  "lastPromotedAt" TIMESTAMPTZ DEFAULT '1970-01-01T00:00:00.000Z' ,
  "draft" BOOL DEFAULT true ,
  "showAuthor" BOOL NOT NULL DEFAULT false ,
  "spotlightImageId" TEXT ,
  "spotlightDarkImageId" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "description" JSONB ,
  "description_latest" TEXT 
);

CREATE INDEX IF NOT EXISTS "idx_Spotlights_schemaVersion" ON "Spotlights" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Spotlights_lastPromotedAt" ON "Spotlights" USING btree ( "lastPromotedAt" );

CREATE INDEX IF NOT EXISTS "idx_Spotlights_position" ON "Spotlights" USING btree ( "position" );

CREATE TABLE "Subscriptions" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "state" TEXT ,
  "documentId" TEXT ,
  "collectionName" TEXT ,
  "deleted" BOOL DEFAULT false ,
  "type" TEXT ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Subscriptions_schemaVersion" ON "Subscriptions" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Subscriptions_userId_documentId_collectionName_type_createdAt" ON "Subscriptions" USING btree ( "userId" , "documentId" , "collectionName" , "type" , "createdAt" );

CREATE TABLE "TagFlags" (
  _id VARCHAR(27) PRIMARY KEY ,
  "name" TEXT ,
  "deleted" BOOL DEFAULT false ,
  "slug" TEXT ,
  "order" DOUBLE PRECISION ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "contents" JSONB ,
  "contents_latest" TEXT 
);

CREATE INDEX IF NOT EXISTS "idx_TagFlags_schemaVersion" ON "TagFlags" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_TagFlags_deleted_order_name" ON "TagFlags" USING btree ( "deleted" , "order" , "name" );

CREATE TABLE "TagRels" (
  _id VARCHAR(27) PRIMARY KEY ,
  "tagId" VARCHAR(27) ,
  "postId" VARCHAR(27) ,
  "deleted" BOOL DEFAULT false ,
  "userId" VARCHAR(27) ,
  "backfilled" BOOL DEFAULT false ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "voteCount" DOUBLE PRECISION DEFAULT 0 ,
  "baseScore" DOUBLE PRECISION DEFAULT 0 ,
  "extendedScore" JSONB ,
  "score" DOUBLE PRECISION DEFAULT 0 ,
  "inactive" BOOL ,
  "afBaseScore" DOUBLE PRECISION ,
  "afExtendedScore" JSONB ,
  "afVoteCount" DOUBLE PRECISION 
);

CREATE INDEX IF NOT EXISTS "idx_TagRels_schemaVersion" ON "TagRels" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_TagRels_postId" ON "TagRels" USING btree ( "postId" );

CREATE INDEX IF NOT EXISTS "idx_TagRels_tagId" ON "TagRels" USING btree ( "tagId" );

CREATE TABLE "Tags" (
  _id VARCHAR(27) PRIMARY KEY ,
  "name" TEXT ,
  "shortName" TEXT ,
  "subtitle" TEXT ,
  "slug" TEXT ,
  "oldSlugs" TEXT[] ,
  "core" BOOL DEFAULT false ,
  "suggestedAsFilter" BOOL DEFAULT false ,
  "defaultOrder" DOUBLE PRECISION DEFAULT 0 ,
  "descriptionTruncationCount" DOUBLE PRECISION DEFAULT 0 ,
  "postCount" DOUBLE PRECISION DEFAULT 0 ,
  "userId" VARCHAR(27) ,
  "adminOnly" BOOL DEFAULT false ,
  "canEditUserIds" VARCHAR(27)[] ,
  "charsAdded" DOUBLE PRECISION ,
  "charsRemoved" DOUBLE PRECISION ,
  "deleted" BOOL DEFAULT false ,
  "lastCommentedAt" TIMESTAMPTZ ,
  "lastSubforumCommentAt" TIMESTAMPTZ ,
  "needsReview" BOOL DEFAULT true ,
  "reviewedByUserId" VARCHAR(27) ,
  "wikiGrade" INTEGER DEFAULT 2 ,
  "wikiOnly" BOOL DEFAULT false ,
  "bannerImageId" TEXT ,
  "squareImageId" TEXT ,
  "tagFlagsIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "lesswrongWikiImportRevision" TEXT ,
  "lesswrongWikiImportSlug" TEXT ,
  "lesswrongWikiImportCompleted" BOOL ,
  "htmlWithContributorAnnotations" TEXT ,
  "contributionStats" JSONB ,
  "introSequenceId" VARCHAR(27) ,
  "postsDefaultSortOrder" TEXT ,
  "canVoteOnRels" TEXT[] ,
  "isSubforum" BOOL DEFAULT false ,
  "subforumModeratorIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "subforumIntroPostId" VARCHAR(27) ,
  "parentTagId" VARCHAR(27) ,
  "subTagIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "autoTagModel" TEXT DEFAULT '' ,
  "autoTagPrompt" TEXT DEFAULT '' ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "description" JSONB ,
  "description_latest" TEXT ,
  "subforumWelcomeText" JSONB ,
  "subforumWelcomeText_latest" TEXT ,
  "moderationGuidelines" JSONB ,
  "moderationGuidelines_latest" TEXT 
);

CREATE INDEX IF NOT EXISTS "idx_Tags_schemaVersion" ON "Tags" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_adminOnly" ON "Tags" USING btree ( "deleted" , "adminOnly" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_adminOnly_name" ON "Tags" USING btree ( "deleted" , "adminOnly" , "name" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_userId_createdAt" ON "Tags" USING btree ( "deleted" , "userId" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_adminOnly_wikiOnly_createdAt" ON "Tags" USING btree ( "deleted" , "adminOnly" , "wikiOnly" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_adminOnly_wikiGrade_defaultOrder_postCount_name" ON "Tags" USING btree ( "deleted" , "adminOnly" , "wikiGrade" , "defaultOrder" , "postCount" , "name" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_slug_oldSlugs" ON "Tags" USING gin ( "deleted" , "slug" , "oldSlugs" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_core_name" ON "Tags" USING btree ( "deleted" , "core" , "name" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_core_name" ON "Tags" USING btree ( "deleted" , "core" , "name" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_createdAt" ON "Tags" USING btree ( "deleted" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_needsReview_createdAt" ON "Tags" USING btree ( "deleted" , "needsReview" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_adminOnly_suggestedAsFilter_defaultOrder_name" ON "Tags" USING btree ( "deleted" , "adminOnly" , "suggestedAsFilter" , "defaultOrder" , "name" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_adminOnly_lesswrongWikiImportSlug" ON "Tags" USING btree ( "deleted" , "adminOnly" , "lesswrongWikiImportSlug" );

CREATE INDEX IF NOT EXISTS "idx_Tags_deleted_adminOnly_tagFlagsIds" ON "Tags" USING gin ( "deleted" , "adminOnly" , "tagFlagsIds" );

CREATE INDEX IF NOT EXISTS "idx_Tags_name" ON "Tags" USING btree ( "name" );

CREATE INDEX IF NOT EXISTS "idx_Tags_parentTagId" ON "Tags" USING btree ( "parentTagId" );

CREATE TABLE "UserActivities" (
  _id VARCHAR(27) PRIMARY KEY ,
  "visitorId" TEXT ,
  "type" TEXT ,
  "startDate" TIMESTAMPTZ ,
  "endDate" TIMESTAMPTZ ,
  "activityArray" DOUBLE PRECISION[] ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_UserActivities_schemaVersion" ON "UserActivities" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_UserActivities_visitorId_type" ON "UserActivities" USING btree ( "visitorId" , "type" );

CREATE TABLE "UserMostValuablePosts" (
  _id VARCHAR(27) PRIMARY KEY ,
  "userId" VARCHAR(27) ,
  "postId" VARCHAR(27) ,
  "deleted" BOOL DEFAULT false ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_UserMostValuablePosts_schemaVersion" ON "UserMostValuablePosts" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_UserMostValuablePosts_userId_deleted" ON "UserMostValuablePosts" USING btree ( "userId" , "deleted" );

CREATE INDEX IF NOT EXISTS "idx_UserMostValuablePosts_userId_postId_deleted" ON "UserMostValuablePosts" USING btree ( "userId" , "postId" , "deleted" );

CREATE TABLE "UserTagRels" (
  _id VARCHAR(27) PRIMARY KEY ,
  "tagId" VARCHAR(27) ,
  "userId" VARCHAR(27) ,
  "subforumLastVisitedAt" TIMESTAMPTZ ,
  "subforumShowUnreadInSidebar" BOOL NOT NULL DEFAULT true ,
  "subforumEmailNotifications" BOOL NOT NULL DEFAULT false ,
  "subforumHideIntroPost" BOOL DEFAULT false ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_UserTagRels_schemaVersion" ON "UserTagRels" USING btree ( "schemaVersion" );

CREATE UNIQUE INDEX IF NOT EXISTS "idx_UserTagRels_tagId_userId" ON "UserTagRels" USING btree ( COALESCE("tagId", '') , COALESCE("userId", '') );

CREATE TABLE "Users" (
  _id VARCHAR(27) PRIMARY KEY ,
  "username" TEXT ,
  "emails" JSONB[] ,
  "isAdmin" BOOL ,
  "profile" JSONB ,
  "services" JSONB ,
  "displayName" TEXT ,
  "previousDisplayName" TEXT ,
  "email" TEXT ,
  "slug" TEXT ,
  "noindex" BOOL DEFAULT false ,
  "groups" TEXT[] ,
  "lwWikiImport" BOOL ,
  "theme" JSONB DEFAULT '{"name":"auto"}'::JSONB ,
  "lastUsedTimezone" TEXT ,
  "whenConfirmationEmailSent" TIMESTAMPTZ ,
  "legacy" BOOL DEFAULT false ,
  "commentSorting" TEXT ,
  "sortDraftsBy" TEXT ,
  "noKibitz" BOOL ,
  "showHideKarmaOption" BOOL ,
  "showPostAuthorCard" BOOL ,
  "hideIntercom" BOOL DEFAULT false ,
  "markDownPostEditor" BOOL DEFAULT false ,
  "hideElicitPredictions" BOOL DEFAULT false ,
  "hideAFNonMemberInitialWarning" BOOL DEFAULT false ,
  "noSingleLineComments" BOOL DEFAULT false ,
  "noCollapseCommentsPosts" BOOL DEFAULT false ,
  "noCollapseCommentsFrontpage" BOOL DEFAULT false ,
  "showCommunityInRecentDiscussion" BOOL DEFAULT false ,
  "noComicSans" BOOL DEFAULT false ,
  "petrovOptOut" BOOL DEFAULT false ,
  "acceptedTos" BOOL DEFAULT false ,
  "hideNavigationSidebar" BOOL ,
  "currentFrontpageFilter" TEXT ,
  "frontpageFilterSettings" JSONB ,
  "hideFrontpageFilterSettingsDesktop" BOOL ,
  "allPostsTimeframe" TEXT ,
  "allPostsFilter" TEXT ,
  "allPostsSorting" TEXT ,
  "allPostsShowLowKarma" BOOL ,
  "allPostsIncludeEvents" BOOL ,
  "allPostsHideCommunity" BOOL ,
  "allPostsOpenSettings" BOOL ,
  "draftsListSorting" TEXT ,
  "draftsListShowArchived" BOOL ,
  "draftsListShowShared" BOOL ,
  "lastNotificationsCheck" TIMESTAMPTZ ,
  "karma" DOUBLE PRECISION ,
  "goodHeartTokens" DOUBLE PRECISION ,
  "moderationStyle" TEXT ,
  "moderatorAssistance" BOOL ,
  "collapseModerationGuidelines" BOOL ,
  "bannedUserIds" VARCHAR(27)[] ,
  "bannedPersonalUserIds" VARCHAR(27)[] ,
  "bookmarkedPostsMetadata" JSONB[] DEFAULT '{}'::JSONB[] ,
  "hiddenPostsMetadata" JSONB[] DEFAULT '{}'::JSONB[] ,
  "legacyId" TEXT ,
  "deleted" BOOL DEFAULT false ,
  "voteBanned" BOOL ,
  "nullifyVotes" BOOL ,
  "deleteContent" BOOL ,
  "banned" TIMESTAMPTZ ,
  "auto_subscribe_to_my_posts" BOOL DEFAULT true ,
  "auto_subscribe_to_my_comments" BOOL DEFAULT true ,
  "autoSubscribeAsOrganizer" BOOL DEFAULT true ,
  "notificationCommentsOnSubscribedPost" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationShortformContent" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationRepliesToMyComments" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationRepliesToSubscribedComments" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationSubscribedUserPost" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationPostsInGroups" JSONB DEFAULT '{"channel":"both","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationSubscribedTagPost" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationPrivateMessage" JSONB DEFAULT '{"channel":"both","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationSharedWithMe" JSONB DEFAULT '{"channel":"both","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationAlignmentSubmissionApproved" JSONB DEFAULT '{"channel":"both","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationEventInRadius" JSONB DEFAULT '{"channel":"both","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationRSVPs" JSONB DEFAULT '{"channel":"both","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationGroupAdministration" JSONB DEFAULT '{"channel":"both","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationCommentsOnDraft" JSONB DEFAULT '{"channel":"both","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationPostsNominatedReview" JSONB DEFAULT '{"channel":"both","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationSubforumUnread" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"daily","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationNewMention" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationDebateCommentsOnSubscribedPost" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"daily","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "notificationDebateReplies" JSONB DEFAULT '{"channel":"onsite","batchingFrequency":"realtime","timeOfDayGMT":12,"dayOfWeekGMT":"Monday"}'::JSONB ,
  "karmaChangeNotifierSettings" JSONB DEFAULT '{"updateFrequency":"daily","timeOfDayGMT":11,"dayOfWeekGMT":"Saturday","showNegativeKarma":false}'::JSONB ,
  "karmaChangeLastOpened" TIMESTAMPTZ ,
  "karmaChangeBatchStart" TIMESTAMPTZ ,
  "emailSubscribedToCurated" BOOL ,
  "subscribedToDigest" BOOL DEFAULT false ,
  "unsubscribeFromAll" BOOL ,
  "hideSubscribePoke" BOOL DEFAULT false ,
  "hideMeetupsPoke" BOOL DEFAULT false ,
  "frontpagePostCount" DOUBLE PRECISION DEFAULT 0 ,
  "sequenceCount" DOUBLE PRECISION DEFAULT 0 ,
  "sequenceDraftCount" DOUBLE PRECISION DEFAULT 0 ,
  "mongoLocation" JSONB ,
  "googleLocation" JSONB ,
  "location" TEXT ,
  "mapLocation" JSONB ,
  "mapLocationSet" BOOL ,
  "mapMarkerText" TEXT ,
  "htmlMapMarkerText" TEXT ,
  "nearbyEventsNotifications" BOOL DEFAULT false ,
  "nearbyEventsNotificationsLocation" JSONB ,
  "nearbyEventsNotificationsMongoLocation" JSONB ,
  "nearbyEventsNotificationsRadius" DOUBLE PRECISION ,
  "nearbyPeopleNotificationThreshold" DOUBLE PRECISION ,
  "hideFrontpageMap" BOOL ,
  "hideTaggingProgressBar" BOOL ,
  "hideFrontpageBookAd" BOOL ,
  "hideFrontpageBook2019Ad" BOOL ,
  "sunshineNotes" TEXT DEFAULT '' ,
  "sunshineFlagged" BOOL DEFAULT false ,
  "needsReview" BOOL DEFAULT false ,
  "sunshineSnoozed" BOOL DEFAULT false ,
  "snoozedUntilContentCount" DOUBLE PRECISION ,
  "reviewedByUserId" VARCHAR(27) ,
  "reviewedAt" TIMESTAMPTZ ,
  "afKarma" DOUBLE PRECISION DEFAULT 0 ,
  "voteCount" DOUBLE PRECISION ,
  "smallUpvoteCount" DOUBLE PRECISION ,
  "smallDownvoteCount" DOUBLE PRECISION ,
  "bigUpvoteCount" DOUBLE PRECISION ,
  "bigDownvoteCount" DOUBLE PRECISION ,
  "usersContactedBeforeReview" TEXT[] ,
  "fullName" TEXT ,
  "shortformFeedId" VARCHAR(27) ,
  "viewUnreviewedComments" BOOL ,
  "partiallyReadSequences" JSONB[] ,
  "beta" BOOL ,
  "reviewVotesQuadratic" BOOL ,
  "reviewVotesQuadratic2019" BOOL ,
  "reviewVotesQuadratic2020" BOOL ,
  "petrovPressedButtonDate" TIMESTAMPTZ ,
  "petrovLaunchCodeDate" TIMESTAMPTZ ,
  "defaultToCKEditor" BOOL ,
  "signUpReCaptchaRating" DOUBLE PRECISION ,
  "oldSlugs" TEXT[] ,
  "noExpandUnreadCommentsReview" BOOL DEFAULT false ,
  "postCount" DOUBLE PRECISION DEFAULT 0 ,
  "maxPostCount" DOUBLE PRECISION DEFAULT 0 ,
  "commentCount" DOUBLE PRECISION DEFAULT 0 ,
  "maxCommentCount" DOUBLE PRECISION DEFAULT 0 ,
  "tagRevisionCount" DOUBLE PRECISION DEFAULT 0 ,
  "abTestKey" TEXT ,
  "abTestOverrides" JSONB ,
  "reenableDraftJs" BOOL ,
  "walledGardenInvite" BOOL ,
  "hideWalledGardenUI" BOOL ,
  "walledGardenPortalOnboarded" BOOL ,
  "taggingDashboardCollapsed" BOOL ,
  "usernameUnset" BOOL DEFAULT false ,
  "paymentEmail" TEXT ,
  "paymentInfo" TEXT ,
  "profileImageId" TEXT ,
  "jobTitle" TEXT ,
  "organization" TEXT ,
  "careerStage" TEXT[] ,
  "website" TEXT ,
  "fmCrosspostUserId" TEXT ,
  "linkedinProfileURL" TEXT ,
  "facebookProfileURL" TEXT ,
  "twitterProfileURL" TEXT ,
  "githubProfileURL" TEXT ,
  "profileTagIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "organizerOfGroupIds" VARCHAR(27)[] DEFAULT '{}'::VARCHAR(27)[] ,
  "programParticipation" TEXT[] ,
  "postingDisabled" BOOL ,
  "allCommentingDisabled" BOOL ,
  "commentingOnOtherUsersDisabled" BOOL ,
  "conversationsDisabled" BOOL ,
  "acknowledgedNewUserGuidelines" BOOL ,
  "subforumPreferredLayout" TEXT ,
  "experiencedIn" TEXT[] ,
  "interestedIn" TEXT[] ,
  "allowDatadogSessionReplay" BOOL DEFAULT false ,
  "afPostCount" DOUBLE PRECISION DEFAULT 0 ,
  "afCommentCount" DOUBLE PRECISION DEFAULT 0 ,
  "afSequenceCount" DOUBLE PRECISION DEFAULT 0 ,
  "afSequenceDraftCount" DOUBLE PRECISION DEFAULT 0 ,
  "reviewForAlignmentForumUserId" TEXT ,
  "afApplicationText" TEXT ,
  "afSubmittedApplication" BOOL ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB ,
  "moderationGuidelines" JSONB ,
  "moderationGuidelines_latest" TEXT ,
  "howOthersCanHelpMe" JSONB ,
  "howOthersCanHelpMe_latest" TEXT ,
  "howICanHelpOthers" JSONB ,
  "howICanHelpOthers_latest" TEXT ,
  "biography" JSONB ,
  "biography_latest" TEXT ,
  "recommendationSettings" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Users_schemaVersion" ON "Users" USING btree ( "schemaVersion" );

CREATE UNIQUE INDEX IF NOT EXISTS "idx_Users_username" ON "Users" USING btree ( COALESCE("username", '') );

CREATE INDEX IF NOT EXISTS "idx_Users_email" ON "Users" USING btree ( "email" );

CREATE INDEX IF NOT EXISTS "idx_Users_emails__address" ON "Users" USING gin ( "emails" );

CREATE INDEX IF NOT EXISTS "idx_Users_services__resume__loginTokens__hashedToken" ON "Users" USING gin ( ("services"->'resume'->'loginTokens'->'hashedToken') );

CREATE INDEX IF NOT EXISTS "idx_Users_services__resume__loginTokens__token" ON "Users" USING gin ( ("services"->'resume'->'loginTokens'->'token') );

CREATE INDEX IF NOT EXISTS "idx_Users_services__resume__haveLoginTokensToDelete" ON "Users" USING gin ( ("services"->'resume'->'haveLoginTokensToDelete') );

CREATE INDEX IF NOT EXISTS "idx_Users_services__resume__loginTokens__when" ON "Users" USING gin ( ("services"->'resume'->'loginTokens'->'when') );

CREATE INDEX IF NOT EXISTS "idx_Users_services__email__verificationTokens__token" ON "Users" USING gin ( ("services"->'email'->'verificationTokens'->'token') );

CREATE INDEX IF NOT EXISTS "idx_Users_services__password__reset__token" ON "Users" USING gin ( ("services"->'password'->'reset'->'token') );

CREATE INDEX IF NOT EXISTS "idx_Users_services__password__reset__when" ON "Users" USING gin ( ("services"->'password'->'reset'->'when') );

CREATE INDEX IF NOT EXISTS "idx_Users_services__twitter__id" ON "Users" USING gin ( ("services"->'twitter'->'id') );

CREATE INDEX IF NOT EXISTS "idx_Users_services__facebook__id" ON "Users" USING gin ( ("services"->'facebook'->'id') );

CREATE INDEX IF NOT EXISTS "idx_Users_services__google__id" ON "Users" USING gin ( ("services"->'google'->'id') );

CREATE INDEX IF NOT EXISTS "idx_Users_karma__id" ON "Users" USING btree ( "karma" , "_id" );

CREATE INDEX IF NOT EXISTS "idx_Users_slug" ON "Users" USING btree ( "slug" );

CREATE INDEX IF NOT EXISTS "idx_Users_isAdmin" ON "Users" USING btree ( "isAdmin" );

CREATE INDEX IF NOT EXISTS "idx_Users_services__github__id" ON "Users" USING gin ( ("services"->'github'->'id') );

CREATE INDEX IF NOT EXISTS "idx_Users_createdAt__id" ON "Users" USING btree ( "createdAt" , "_id" );

CREATE INDEX IF NOT EXISTS "idx_Users_services__resume__loginTokens" ON "Users" USING gin ( ("services"->'resume'->'loginTokens') );

CREATE INDEX IF NOT EXISTS "idx_Users_email_ci" ON "Users" USING btree ( LOWER("email") );

CREATE INDEX IF NOT EXISTS "idx_Users_emails__address_ci" ON "Users" USING gin ( "emails" );

CREATE INDEX IF NOT EXISTS "idx_Users_email" ON "Users" USING btree ( "email" );

CREATE INDEX IF NOT EXISTS "idx_Users_oldSlugs" ON "Users" USING gin ( "oldSlugs" );

CREATE INDEX IF NOT EXISTS "idx_Users_bannedPersonalUserIds_createdAt" ON "Users" USING gin ( "bannedPersonalUserIds" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Users_bannedUserIds_createdAt" ON "Users" USING gin ( "bannedUserIds" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Users_needsReview_signUpReCaptchaRating_createdAt" ON "Users" USING btree ( "needsReview" , "signUpReCaptchaRating" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Users_reviewedAt_createdAt" ON "Users" USING btree ( "reviewedAt" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Users_mapLocationSet" ON "Users" USING btree ( "mapLocationSet" );

CREATE INDEX IF NOT EXISTS "idx_Users_profileTagIds_deleted_deleteContent_karma" ON "Users" USING gin ( "profileTagIds" , "deleted" , "deleteContent" , "karma" );

CREATE INDEX IF NOT EXISTS "idx_Users_walledGardenInvite" ON "Users" USING btree ( "walledGardenInvite" );

CREATE INDEX IF NOT EXISTS "idx_Users_afKarma_reviewForAlignmentForumUserId_groups_createdAt" ON "Users" USING gin ( "afKarma" , "reviewForAlignmentForumUserId" , "groups" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_Users_afSubmittedApplication_reviewForAlignmentForumUserId_groups_createdAt" ON "Users" USING gin ( "afSubmittedApplication" , "reviewForAlignmentForumUserId" , "groups" , "createdAt" );

CREATE INDEX IF NOT EXISTS "idx_users_nearbyEventsNotifications" ON "Users" USING btree ( "nearbyEventsNotificationsMongoLocation" );

CREATE TABLE "Votes" (
  _id VARCHAR(27) PRIMARY KEY ,
  "documentId" TEXT ,
  "collectionName" TEXT ,
  "userId" VARCHAR(27) ,
  "authorIds" VARCHAR(27)[] ,
  "voteType" TEXT ,
  "extendedVoteType" JSONB ,
  "power" DOUBLE PRECISION ,
  "afPower" DOUBLE PRECISION ,
  "cancelled" BOOL DEFAULT false ,
  "isUnvote" BOOL DEFAULT false ,
  "votedAt" TIMESTAMPTZ ,
  "documentIsAf" BOOL DEFAULT false ,
  "schemaVersion" DOUBLE PRECISION DEFAULT 1 ,
  "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  "legacyData" JSONB 
);

CREATE INDEX IF NOT EXISTS "idx_Votes_schemaVersion" ON "Votes" USING btree ( "schemaVersion" );

CREATE INDEX IF NOT EXISTS "idx_Votes_cancelled_userId_documentId" ON "Votes" USING btree ( "cancelled" , "userId" , "documentId" );

CREATE INDEX IF NOT EXISTS "idx_Votes_cancelled_documentId" ON "Votes" USING btree ( "cancelled" , "documentId" );

CREATE INDEX IF NOT EXISTS "idx_Votes_cancelled_userId_votedAt" ON "Votes" USING btree ( "cancelled" , "userId" , "votedAt" );

CREATE INDEX IF NOT EXISTS "idx_Votes_authorIds_votedAt_userId_afPower" ON "Votes" USING gin ( "authorIds" , "votedAt" , "userId" , "afPower" );

CREATE INDEX IF NOT EXISTS "idx_Votes_collectionName_votedAt" ON "Votes" USING btree ( "collectionName" , "votedAt" );

CREATE INDEX IF NOT EXISTS "idx_Votes_collectionName_userId_voteType_cancelled_isUnvote_votedAt" ON "Votes" USING btree ( "collectionName" , "userId" , "voteType" , "cancelled" , "isUnvote" , "votedAt" );

CREATE INDEX IF NOT EXISTS "idx_Votes_documentId" ON "Votes" USING btree ( "documentId" );

