const db = require('../db');

module.exports = {
  getAll: async () => {
    const { rows } = await db.query('SELECT * FROM catalog');
    return rows;
  },

  getById: async (id) => {
    const { rows } = await db.query('SELECT * FROM catalog WHERE book_id = $1', [id]);
    return rows[0];
  },

  search: async (query) => {
    const { rows } = await db.query(
      `SELECT * FROM catalog 
       WHERE title ILIKE $1 OR dewey ILIKE $1 OR publisher ILIKE $1`,
      [`%${query}%`]
    );
    return rows;
  },

  create: async (bookData) => {
    const { rows } = await db.query(
      `INSERT INTO catalog 
       (title, location_name, dewey, publication_year, summary, format, page_count, publisher, book_status)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *`,
      [
        bookData.title,
        bookData.location_name,
        bookData.dewey,
        bookData.publication_year,
        bookData.summary,
        bookData.format,
        bookData.page_count,
        bookData.publisher,
        bookData.book_status || 'available'
      ]
    );
    return rows[0];
  },

  updateStatus: async (id, status) => {
    const { rows } = await db.query(
      'UPDATE catalog SET book_status = $1 WHERE book_id = $2 RETURNING *',
      [status, id]
    );
    return rows[0];
  }
};