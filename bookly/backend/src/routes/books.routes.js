const express = require('express');

const {
  createBook,
  listBooks,
  getBookById,
  updateBook,
  deleteBook,
} = require('../controllers/books.controller');

const router = express.Router();

router.post('/', createBook);
router.get('/', listBooks);
router.get('/:id', getBookById);
router.put('/:id', updateBook);
router.delete('/:id', deleteBook);

module.exports = router;