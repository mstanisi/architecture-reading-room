const express = require('express');
const router = express.Router();
const loanModel = require('../models/loan');

// Get all active loans
router.get('/', async (req, res) => {
  try {
    const loans = await loanModel.getActiveLoans();
    res.json(loans);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Return a book (end a loan)
router.delete('/:id', async (req, res) => {
  try {
    await loanModel.returnBook(req.params.id);
    res.json({ message: 'Book returned successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Create a new loan
router.post('/', async (req, res) => {
  try {
    // In a real application, you would validate the input data first
    const newLoan = await loanModel.create(req.body);
    res.status(201).json(newLoan);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;