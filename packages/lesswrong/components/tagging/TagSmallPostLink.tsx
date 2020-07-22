import React from 'react';
import { registerComponent, Components } from '../../lib/vulcan-lib';
import { useHover } from '../common/withHover';
import { Link } from '../../lib/reactRouterWrapper';
import { Posts } from '../../lib/collections/posts';
import classNames from 'classnames';

const styles = theme => ({
  root: {
    display: "flex",
    ...theme.typography.body2,
    ...theme.typography.postStyle,
    color: theme.palette.grey[900],
  },
  karma: {
    width: 27,
    textAlign: "center",
    flexShrink: 0
  },
  post: {
    display: "flex",
    width: "100%",
    justifyContent: "space-between",
    marginTop: 2,
    marginBottom: 2,
  },
  title: {
    position: "relative",
    top: 2,
    overflow: "hidden",
    textOverflow: "ellipsis",
    whiteSpace: "nowrap",
    flexGrow: 1,
  },
  wrap: {
    whiteSpace: "unset",
    lineHeight: "1.1em",
    marginBottom: 4,
  },
  author: {
    marginRight: 0,
    marginLeft: 20
  }
});

const TagSmallPostLink = ({classes, post, hideMeta, wrap}: {
  classes: ClassesType,
  post: PostsList,
  hideMeta?: boolean,
  wrap?: boolean
}) => {
  const { LWPopper, PostsPreviewTooltip, UsersName, MetaInfo } = Components
  const { eventHandlers, hover, anchorEl } = useHover();

  return <span {...eventHandlers}>
    <div className={classes.root}>
      <LWPopper 
        open={hover} 
        anchorEl={anchorEl} 
        placement="left-start"
        modifiers={{
          flip: {
            behavior: ["bottom-end", "top", "bottom-end"],
            boundariesElement: 'viewport'
          } 
        }}
      >
        <PostsPreviewTooltip post={post}/>
      </LWPopper>
      <div className={classes.post}>
        {!hideMeta && <MetaInfo className={classes.karma}>{post.baseScore}</MetaInfo>}
        <Link to={Posts.getPageUrl(post)} className={classNames(classes.title, {[classes.wrap]: wrap})}>
          {post.title}
        </Link>
        {!hideMeta && <MetaInfo className={classes.author}>
          <UsersName user={post.user} />
        </MetaInfo>}
      </div>
    </div>
  </span>
}

const TagSmallPostLinkComponent = registerComponent("TagSmallPostLink", TagSmallPostLink, {styles});

declare global {
  interface ComponentTypes {
    TagSmallPostLink: typeof TagSmallPostLinkComponent
  }
}

