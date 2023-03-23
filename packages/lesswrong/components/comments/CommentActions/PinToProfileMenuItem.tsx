import React from 'react';
import { registerComponent, Components } from '../../../lib/vulcan-lib';
import { useCurrentUser } from '../../common/withUser';
import { useUpdateComment } from '../../hooks/useUpdateComment';
import { StickyIcon } from '../../posts/PostsTitle';
import ListItemIcon from '@material-ui/core/ListItemIcon';


const PinToProfileMenuItem = ({ comment }: {
  comment: CommentsList,
}) => {
  const currentUser = useCurrentUser()
  const { MenuItem } = Components;
  const updateComment = useUpdateComment();

  const togglePinned = async () => {
    await updateComment(comment._id, {
      isPinnedOnProfile: !comment.isPinnedOnProfile
    });
  }
  
  const username = currentUser?._id === comment.userId ? 'my' : `${comment.user?.displayName}'s`

  return <MenuItem onClick={togglePinned}>
    <ListItemIcon>
      <StickyIcon className="MuiSvgIcon-root" />
    </ListItemIcon>
    {comment.isPinnedOnProfile ? `Unpin from ${username} profile` : `Pin to ${username} profile`}
  </MenuItem>
}

const PinToProfileMenuItemComponent = registerComponent('PinToProfileMenuItem', PinToProfileMenuItem);

declare global {
  interface ComponentTypes {
    PinToProfileMenuItem: typeof PinToProfileMenuItemComponent
  }
}
