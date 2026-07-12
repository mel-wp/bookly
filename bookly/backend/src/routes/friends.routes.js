const express = require('express');

const {
  createFriend,
  listFriends,
  getFriendById,
  updateFriend,
  deleteFriend,
} = require('../controllers/friends.controller');

const router = express.Router();

router.post('/', createFriend);
router.get('/', listFriends);
router.get('/:id', getFriendById);
router.put('/:id', updateFriend);
router.delete('/:id', deleteFriend);

module.exports = router;