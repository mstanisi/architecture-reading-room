const express = require('express');
const router = express.Router();
const bookModel = require('../models/book');

router.get('/', async (req, res) => {
  try {
    const books = await bookModel.getAll();
    res.json(books);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/search', async (req, res) => {
  try {
    const query = req.query.q;
    if (!query) {
      return res.status(400).json({ error: 'Search query is required' });
    }
    const results = await bookModel.search(query);
    res.json(results);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.post('/', async (req, res) => {
  try {
    const newBook = await bookModel.create(req.body);
    res.status(201).json(newBook);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.put('/:id/status', async (req, res) => {
  try {
    const book = await bookModel.updateStatus(req.params.id, req.body.status);
    if (!book) {
      return res.status(404).json({ error: 'Book not found' });
    }
    res.json(book);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;