const db = require('../db');

module.exports = {
  create: async (loanData) => {
    // First update the book status to 'on_loan'
    await db.query(
      'UPDATE catalog SET book_status = $1 WHERE book_id = $2',
      ['on_loan', loanData.book_id]
    );

    // Then create the loan record
    const { rows } = await db.query(
      `INSERT INTO loan 
       (member_id, book_id, clerk_id, loan_date, due_date)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [
        loanData.member_id,
        loanData.book_id,
        loanData.clerk_id || 1, // Default clerk if not provided
        loanData.loan_date || new Date().toISOString().split('T')[0], // Default to today
        loanData.due_date || getDueDate(14) // Default to 14 days from now
      ]
    );
    return rows[0];
  },

  getActiveLoans: async () => {
    const { rows } = await db.query(
      `SELECT l.*, m.first_name, m.last_name, c.title 
       FROM loan l
       JOIN member m ON l.member_id = m.member_id
       JOIN catalog c ON l.book_id = c.book_id
       WHERE c.book_status = 'on_loan'`
    );
    return rows;
  },

  returnBook: async (loanId) => {
    // Get the loan to find the book_id
    const loan = await db.query('SELECT book_id FROM loan WHERE loan_id = $1', [loanId]);
    
    if (loan.rows.length === 0) {
      throw new Error('Loan not found');
    }

    // Update book status to available
    await db.query(
      "UPDATE catalog SET book_status = 'available' WHERE book_id = $1",
      [loan.rows[0].book_id]
    );
    
    // Delete the loan record
    await db.query('DELETE FROM loan WHERE loan_id = $1', [loanId]);
  }
};

// Helper function to calculate due date (n days from today)
function getDueDate(days) {
  const date = new Date();
  date.setDate(date.getDate() + days);
  return date.toISOString().split('T')[0];
}