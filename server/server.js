const express = require('express');
const cors = require('cors');
const config = require('./config');
const bookRoutes = require('./routes/books');
const loanRoutes = require('./routes/loans');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// Routes
app.use('/api/books', bookRoutes);
app.use('/api/loans', loanRoutes);

// Start server
app.listen(config.port, () => {
  console.log(`Server running on port ${config.port}`);
});