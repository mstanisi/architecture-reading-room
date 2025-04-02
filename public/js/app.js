// Global variables
let currentView = '';

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
  loadBooks();
});

// Navigation functions
function loadBooks() {
  currentView = 'books';
  document.getElementById('search').style.display = 'block';
  
  fetch('/api/books')
    .then(response => response.json())
    .then(books => {
      let html = '<h2>Books</h2><button onclick="showAddBookForm()">Add Book</button><ul>';
      
      books.forEach(book => {
        html += `
          <li>
            ${book.title} (${book.publisher}, ${book.publication_year}) - ${formatStatus(book.book_status)}
            <button onclick="viewBookDetails(${book.book_id})">Details</button>
            ${book.book_status === 'available' ? 
              `<button onclick="checkoutBook(${book.book_id})">Checkout</button>` : ''}
          </li>
        `;
      });
      
      html += '</ul>';
      document.getElementById('content').innerHTML = html;
    })
    .catch(err => {
      document.getElementById('content').innerHTML = '<p>Error loading books</p>';
      console.error(err);
    });
}

function loadLoans() {
  currentView = 'loans';
  document.getElementById('search').style.display = 'none';
  
  fetch('/api/loans')
    .then(response => response.json())
    .then(loans => {
      let html = '<h2>Current Loans</h2><table border="1"><tr><th>Book</th><th>Member</th><th>Loan Date</th><th>Due Date</th><th>Action</th></tr>';
      
      loans.forEach(loan => {
        html += `
          <tr>
            <td>${loan.title}</td>
            <td>${loan.first_name} ${loan.last_name}</td>
            <td>${new Date(loan.loan_date).toLocaleDateString()}</td>
            <td>${new Date(loan.due_date).toLocaleDateString()}</td>
            <td><button onclick="returnBook(${loan.loan_id})">Return</button></td>
          </tr>
        `;
      });
      
      html += '</table>';
      document.getElementById('content').innerHTML = html;
    })
    .catch(err => {
      document.getElementById('content').innerHTML = '<p>Error loading loans</p>';
      console.error(err);
    });
}

function loadMembers() {
  currentView = 'members';
  document.getElementById('search').style.display = 'none';
  document.getElementById('content').innerHTML = '<h2>Members</h2><p>Member management coming soon.</p>';
}

// Helper functions
function formatStatus(status) {
  const statusMap = {
    'available': 'Available',
    'on_loan': 'On Loan',
    'on_hold': 'On Hold',
    'damaged': 'Damaged',
    'lost': 'Lost'
  };
  return statusMap[status] || status;
}

function showModal(title, content) {
  document.getElementById('modalTitle').textContent = title;
  document.getElementById('modalBody').innerHTML = content;
  document.getElementById('modal').style.display = 'block';
}

function hideModal() {
  document.getElementById('modal').style.display = 'none';
}

// Book-related functions
function searchBooks() {
  const query = document.getElementById('searchInput').value;
  if (!query) return;

  fetch(`/api/books/search?q=${encodeURIComponent(query)}`)
    .then(response => response.json())
    .then(results => {
      let html = '<ul>';
      results.forEach(book => {
        html += `
          <li>
            ${book.title} (${book.publisher}, ${book.publication_year}) - ${formatStatus(book.book_status)}
            <button onclick="viewBookDetails(${book.book_id})">Details</button>
          </li>
        `;
      });
      html += '</ul>';
      document.getElementById('content').innerHTML = '<h2>Search Results</h2>' + html;
    })
    .catch(err => {
      console.error('Error searching books:', err);
    });
}

function showAddBookForm() {
  const form = `
    <form onsubmit="addBook(event)">
      <div>
        <label>Title: <input type="text" id="title" required></label>
      </div>
      <div>
        <label>Publisher: <input type="text" id="publisher"></label>
      </div>
      <div>
        <label>Year: <input type="number" id="year"></label>
      </div>
      <div>
        <label>Dewey: <input type="text" id="dewey" required></label>
      </div>
      <button type="submit">Save</button>
    </form>
  `;
  showModal('Add New Book', form);
}

function addBook(event) {
  event.preventDefault();
  
  const bookData = {
    title: document.getElementById('title').value,
    publisher: document.getElementById('publisher').value,
    publication_year: document.getElementById('year').value,
    dewey: document.getElementById('dewey').value
  };

  fetch('/api/books', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(bookData)
  })
  .then(response => {
    if (response.ok) {
      hideModal();
      loadBooks();
    } else {
      alert('Error adding book');
    }
  })
  .catch(err => {
    console.error('Error adding book:', err);
    alert('Error adding book');
  });
}

function viewBookDetails(bookId) {
  fetch(`/api/books/${bookId}`)
    .then(response => response.json())
    .then(book => {
      const details = `
        <h3>${book.title}</h3>
        <p>Publisher: ${book.publisher || 'N/A'}</p>
        <p>Year: ${book.publication_year || 'N/A'}</p>
        <p>Dewey: ${book.dewey}</p>
        <p>Status: ${formatStatus(book.book_status)}</p>
        <p>Pages: ${book.page_count || 'N/A'}</p>
        <p>Location: ${book.location_name}</p>
        <p>${book.summary || 'No summary available.'}</p>
      `;
      showModal('Book Details', details);
    })
    .catch(err => {
      console.error('Error fetching book details:', err);
    });
}

function checkoutBook(bookId) {
  // In a real app, you'd select a member and set dates
  const loanData = {
    member_id: 1, // Hardcoded for demo
    book_id: bookId,
    clerk_id: 1, // Hardcoded for demo
    loan_date: new Date().toISOString().split('T')[0],
    due_date: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]
  };

  fetch('/api/loans', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(loanData)
  })
  .then(response => {
    if (response.ok) {
      loadBooks();
    } else {
      alert('Error checking out book');
    }
  })
  .catch(err => {
    console.error('Error checking out book:', err);
    alert('Error checking out book');
  });
}

// Loan-related functions
function returnBook(loanId) {
  fetch(`/api/loans/${loanId}`, {
    method: 'DELETE'
  })
  .then(response => {
    if (response.ok) {
      loadLoans();
    } else {
      alert('Error returning book');
    }
  })
  .catch(err => {
    console.error('Error returning book:', err);
    alert('Error returning book');
  });
}

// Make functions available globally
window.loadBooks = loadBooks;
window.loadLoans = loadLoans;
window.loadMembers = loadMembers;
window.searchBooks = searchBooks;
window.showAddBookForm = showAddBookForm;
window.hideModal = hideModal;
window.viewBookDetails = viewBookDetails;
window.checkoutBook = checkoutBook;
window.returnBook = returnBook;
window.addBook = addBook;