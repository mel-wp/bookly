const express = require('express');

const {
  createLoan,
  listLoans,
  getLoanById,
  updateLoan,
  markLoanAsReturned,
  deleteLoan,
} = require('../controllers/loans.controller');

const router = express.Router();

router.post('/', createLoan);
router.get('/', listLoans);
router.get('/:id', getLoanById);
router.put('/:id', updateLoan);
router.patch('/:id/return', markLoanAsReturned);
router.delete('/:id', deleteLoan);

module.exports = router;