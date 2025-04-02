-- PostgreSQL database dump
-- Database: reading_room

-- Drop existing tables if they exist
DROP TABLE IF EXISTS clerk_to_fee CASCADE;
DROP TABLE IF EXISTS clerk_to_catalog CASCADE;
DROP TABLE IF EXISTS hold CASCADE;
DROP TABLE IF EXISTS fee CASCADE;
DROP TABLE IF EXISTS loan CASCADE;
DROP TABLE IF EXISTS book_contributor CASCADE;
DROP TABLE IF EXISTS book_language CASCADE;
DROP TABLE IF EXISTS book_subject CASCADE;
DROP TABLE IF EXISTS member CASCADE;
DROP TABLE IF EXISTS catalog CASCADE;
DROP TABLE IF EXISTS clerk CASCADE;
DROP TABLE IF EXISTS contributor CASCADE;
DROP TABLE IF EXISTS book_role CASCADE;
DROP TABLE IF EXISTS language CASCADE;
DROP TABLE IF EXISTS subject CASCADE;

-- Table structure for table `book_role`
CREATE TABLE book_role (
  book_role_id SERIAL PRIMARY KEY,
  book_role_name VARCHAR(50) NOT NULL
);

-- Dumping data for table `book_role`
INSERT INTO book_role (book_role_id, book_role_name) VALUES 
(1,'author'),
(2,'editor'),
(3,'translator'),
(4,'introduction'),
(5,'curator');

-- Table structure for table `contributor`
CREATE TABLE contributor (
  contributor_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50) NOT NULL
);

-- Dumping data for table `contributor`
INSERT INTO contributor (contributor_id, first_name, last_name) VALUES 
(1,'Amaranth','Borsuk'),
(2,'Lucien','Febvre'),
(3,'Hendri-Jean','Martin'),
(4,'Lucy','Bullivant'),
(5,'Dennis','Sharp'),
(6,'Charles Brockden','Brown');

-- Table structure for table `language`
CREATE TABLE language (
  language_id SERIAL PRIMARY KEY,
  language_name VARCHAR(50) NOT NULL
);

-- Dumping data for table `language`
INSERT INTO language (language_id, language_name) VALUES 
(1,'English'),
(2,'Polish'),
(3,'German'),
(4,'French'),
(5,'Spanish');

-- Table structure for table `subject`
CREATE TABLE subject (
  subject_id SERIAL PRIMARY KEY,
  subject_name VARCHAR(50)
);

-- Dumping data for table `subject`
INSERT INTO subject (subject_id, subject_name) VALUES 
(1,'literary criticism'),
(2,'sociology'),
(3,'17th century'),
(4,'european history'),
(5,'architecture'),
(6,'urbanism'),
(7,'design'),
(8,'fiction');

-- Table structure for table `clerk`
CREATE TABLE clerk (
  clerk_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(200) NOT NULL UNIQUE
);

-- Dumping data for table `clerk`
INSERT INTO clerk (clerk_id, first_name, last_name, email) VALUES 
(1,'Phil','Ochs','philochs@pratt.edu'),
(2,'Dave Van','Ronk','dvronk@pratt.edu'),
(3,'Woody','Guthrie','woodyguthrie@pratt.edu'),
(4,'Jackson C.','Frank','jcfrank@pratt.edu'),
(5,'Anne','Briggs','annebriggs@pratt.edu');

-- Table structure for table `catalog`
CREATE TABLE catalog (
  book_id SERIAL PRIMARY KEY,
  title VARCHAR(500) NOT NULL,
  location_name VARCHAR(10) DEFAULT 'Menking' CHECK (location_name IN ('Menking','Non-Menking')),
  dewey VARCHAR(50) NOT NULL,
  publication_year INT,
  summary VARCHAR(10000),
  format VARCHAR(500),
  page_count INT,
  publisher VARCHAR(500),
  book_status VARCHAR(10) DEFAULT 'available' CHECK (book_status IN ('available','on_loan','on_hold','damaged','lost'))
);

-- Dumping data for table `catalog`
INSERT INTO catalog (book_id, title, location_name, dewey, publication_year, summary, format, page_count, publisher, book_status) VALUES 
(1,'The Book (The MIT Press Essential Knowledge series)','Menking','2',2018,'The book as object  as content  as idea  as interface.','Paperback',344,'The MIT Press','on_loan'),
(2,'The Coming of the Book: The Impact of Printing  1450-1800','Menking','2',1984,'Books  and the printed word more generally  are aspects of modern life that are all too often taken for granted.','Paperback',378,'Verso Books','available'),
(3,'4dspace: Interactive Architecture (Architectural Design)','Menking','6',2005,'In the next few years  emerging practices in interactive architecture are set to transform the built environment.','Paperback',128,'Wiley Academy Press','available'),
(4,'Sources of Modern Architecture: A Critical Bibliography','Menking','16.7249',1981,'This unique guide to personalities and literature includes listings by architect  subject  and country plus an international periodical list.','Hardcover',192,'Eastview Editions','on_hold'),
(5,'Edgar Huntly  Or  Memoirs of a Sleep-Walker (Penguin Classics)','Non-Menking','813.2',1988,'What would you do if everything you thought you knew about yourself turned out to be wrong?','Paperback',320,'Penguin Publishing Group','on_loan');

-- Table structure for table `member`
CREATE TABLE member (
  member_id SERIAL PRIMARY KEY,
  clerk_id INT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(200) NOT NULL UNIQUE,
  date_registered DATE NOT NULL,
  CONSTRAINT member_clerk_fk FOREIGN KEY (clerk_id) REFERENCES clerk (clerk_id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Dumping data for table `member`
INSERT INTO member (member_id, clerk_id, first_name, last_name, email, date_registered) VALUES 
(1,1,'Glen','Campbell','glencampbell@pratt.edu','1998-12-14'),
(2,2,'Mickey','Newbury','mickeynbury@pratt.edu','1998-12-14'),
(3,4,'Roy','Acuff','royacuff@pratt.edu','1998-12-14'),
(4,3,'Merle','Haggard','mhaggard@pratt.edu','1998-12-14'),
(5,3,'Marty','Robbins','mrobbins@pratt.edu','1998-12-14'),
(6,4,'Waylon','Jennings','wjennings@pratt.edu','2024-12-15');

-- Table structure for table `book_contributor`
CREATE TABLE book_contributor (
  book_contributor_id SERIAL PRIMARY KEY,
  book_id INT NOT NULL,
  contributor_id INT NOT NULL,
  book_role_id INT NOT NULL,
  CONSTRAINT book_contributor_book_fk FOREIGN KEY (book_id) REFERENCES catalog (book_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT book_contributor_contributor_fk FOREIGN KEY (contributor_id) REFERENCES contributor (contributor_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT book_contributor_role_fk FOREIGN KEY (book_role_id) REFERENCES book_role (book_role_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX book_contributor_book_idx ON book_contributor (book_id);
CREATE INDEX book_contributor_contributor_idx ON book_contributor (contributor_id);
CREATE INDEX book_contributor_role_idx ON book_contributor (book_role_id);

-- Dumping data for table `book_contributor`
INSERT INTO book_contributor (book_contributor_id, book_id, contributor_id, book_role_id) VALUES 
(1,1,1,1),
(2,2,2,1),
(3,2,3,1),
(4,3,4,2),
(5,4,5,1),
(6,5,6,1);

-- Table structure for table `book_language`
CREATE TABLE book_language (
  book_language_id SERIAL PRIMARY KEY,
  language_id INT NOT NULL,
  book_id INT NOT NULL,
  CONSTRAINT book_language_language_fk FOREIGN KEY (language_id) REFERENCES language (language_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT book_language_book_fk FOREIGN KEY (book_id) REFERENCES catalog (book_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX book_language_language_idx ON book_language (language_id);
CREATE INDEX book_language_book_idx ON book_language (book_id);

-- Dumping data for table `book_language`
INSERT INTO book_language (book_language_id, language_id, book_id) VALUES 
(1,1,1),
(2,1,2),
(3,2,2),
(4,1,3),
(5,1,4),
(6,1,5);

-- Table structure for table `book_subject`
CREATE TABLE book_subject (
  book_subject_id SERIAL PRIMARY KEY,
  book_id INT,
  subject_id INT,
  CONSTRAINT book_subject_book_fk FOREIGN KEY (book_id) REFERENCES catalog (book_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT book_subject_subject_fk FOREIGN KEY (subject_id) REFERENCES subject (subject_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX book_subject_book_idx ON book_subject (book_id);
CREATE INDEX book_subject_subject_idx ON book_subject (subject_id);

-- Dumping data for table `book_subject`
INSERT INTO book_subject (book_subject_id, book_id, subject_id) VALUES 
(1,1,1),
(2,1,2),
(3,2,3),
(4,2,4),
(5,3,5),
(6,3,6),
(7,3,7),
(8,4,7),
(9,5,8);

-- Table structure for table `clerk_to_catalog`
CREATE TABLE clerk_to_catalog (
  clerk_to_catalog_id SERIAL PRIMARY KEY,
  clerk_id INT NOT NULL,
  book_id INT NOT NULL,
  update_date DATE NOT NULL,
  CONSTRAINT clerk_to_catalog_clerk_fk FOREIGN KEY (clerk_id) REFERENCES clerk (clerk_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT clerk_to_catalog_book_fk FOREIGN KEY (book_id) REFERENCES catalog (book_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX clerk_to_catalog_clerk_idx ON clerk_to_catalog (clerk_id);
CREATE INDEX clerk_to_catalog_book_idx ON clerk_to_catalog (book_id);

-- Dumping data for table `clerk_to_catalog`
INSERT INTO clerk_to_catalog (clerk_to_catalog_id, clerk_id, book_id, update_date) VALUES 
(1,5,1,'1999-12-25'),
(2,5,2,'2023-12-25'),
(3,5,3,'2002-12-25'),
(4,3,4,'1999-12-24'),
(5,5,4,'2001-12-24'),
(6,1,5,'2024-12-15'),
(7,1,4,'2024-12-15');

-- Table structure for table `loan`
CREATE TABLE loan (
  loan_id SERIAL PRIMARY KEY,
  member_id INT,
  book_id INT,
  clerk_id INT NOT NULL,
  loan_date DATE NOT NULL,
  due_date DATE NOT NULL,
  CONSTRAINT loan_member_fk FOREIGN KEY (member_id) REFERENCES member (member_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT loan_book_fk FOREIGN KEY (book_id) REFERENCES catalog (book_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT loan_clerk_fk FOREIGN KEY (clerk_id) REFERENCES clerk (clerk_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT loan_date_check CHECK (due_date > loan_date)
);

CREATE INDEX loan_member_idx ON loan (member_id);
CREATE INDEX loan_book_idx ON loan (book_id);
CREATE INDEX loan_clerk_idx ON loan (clerk_id);

-- Dumping data for table `loan`
INSERT INTO loan (loan_id, member_id, book_id, clerk_id, loan_date, due_date) VALUES 
(1,1,1,1,'1999-12-14','2000-12-14'),
(2,1,2,1,'1999-12-14','2000-12-14'),
(3,2,3,2,'1999-12-14','2000-12-14'),
(4,5,4,5,'1999-12-13','2000-12-14'),
(5,5,5,5,'1999-12-13','2000-12-14'),
(6,5,5,2,'2024-12-15','2025-01-14');

-- Table structure for table `fee`
CREATE TABLE fee (
  fee_id SERIAL PRIMARY KEY,
  loan_id INT,
  payment_status VARCHAR(12) NOT NULL DEFAULT 'outstanding' CHECK (payment_status IN ('paid','outstanding','processing')),
  charge_date DATE,
  amount DECIMAL(10,2),
  CONSTRAINT fee_loan_fk FOREIGN KEY (loan_id) REFERENCES loan (loan_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX fee_loan_idx ON fee (loan_id);

-- Dumping data for table `fee`
INSERT INTO fee (fee_id, loan_id, payment_status, charge_date, amount) VALUES 
(2,2,'paid','2024-12-15',5.50),
(3,3,'processing','2024-12-15',500.50),
(4,4,'paid','2001-12-15',50.00),
(5,5,'paid','2000-12-15',0.50);

-- Table structure for table `clerk_to_fee`
CREATE TABLE clerk_to_fee (
  clerk_to_fee_id SERIAL PRIMARY KEY,
  clerk_id INT,
  fee_id INT,
  clerk_to_fee_action VARCHAR(8) NOT NULL DEFAULT 'bill' CHECK (clerk_to_fee_action IN ('pay off','bill')),
  CONSTRAINT clerk_to_fee_clerk_fk FOREIGN KEY (clerk_id) REFERENCES clerk (clerk_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT clerk_to_fee_fee_fk FOREIGN KEY (fee_id) REFERENCES fee (fee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX clerk_to_fee_clerk_idx ON clerk_to_fee (clerk_id);
CREATE INDEX clerk_to_fee_fee_idx ON clerk_to_fee (fee_id);

-- Dumping data for table `clerk_to_fee`
INSERT INTO clerk_to_fee (clerk_to_fee_id, clerk_id, fee_id, clerk_to_fee_action) VALUES 
(2,5,2,'bill'),
(3,4,3,'bill'),
(4,5,3,'pay off'),
(5,5,4,'pay off'),
(6,5,5,'pay off');

-- Table structure for table `hold`
CREATE TABLE hold (
  hold_id SERIAL PRIMARY KEY,
  book_id INT NOT NULL,
  member_id INT NOT NULL,
  clerk_id INT NOT NULL,
  hold_placed_date DATE NOT NULL,
  CONSTRAINT hold_book_fk FOREIGN KEY (book_id) REFERENCES catalog (book_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT hold_member_fk FOREIGN KEY (member_id) REFERENCES member (member_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT hold_clerk_fk FOREIGN KEY (clerk_id) REFERENCES clerk (clerk_id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE INDEX hold_book_idx ON hold (book_id);
CREATE INDEX hold_member_idx ON hold (member_id);
CREATE INDEX hold_clerk_idx ON hold (clerk_id);

-- Dumping data for table `hold`
INSERT INTO hold (hold_id, book_id, member_id, clerk_id, hold_placed_date) VALUES 
(1,1,3,1,'2001-11-15'),
(2,1,4,1,'2001-10-15'),
(3,3,3,1,'1999-12-25'),
(4,2,4,1,'2024-10-15'),
(5,1,4,1,'2024-12-15'),
(6,4,5,3,'2024-12-15');

-- Create views
CREATE OR REPLACE VIEW languages_view AS
SELECT l.language_name AS language, c.title AS book_title, c.location_name, c.dewey, c.book_status
FROM language l
JOIN book_language bl ON l.language_id = bl.language_id
JOIN catalog c ON bl.book_id = c.book_id
ORDER BY l.language_name, c.title;

CREATE OR REPLACE VIEW member_fees AS
SELECT m.member_id, CONCAT(m.first_name, ' ', m.last_name) AS member_name, 
       l.loan_id, f.fee_id, f.payment_status, f.charge_date, f.amount
FROM member m
JOIN loan l ON m.member_id = l.member_id
JOIN fee f ON l.loan_id = f.loan_id;

CREATE OR REPLACE VIEW subjects_view AS
SELECT s.subject_name AS subject, c.title AS book_title, c.location_name, c.dewey, c.book_status
FROM subject s
JOIN book_subject bs ON s.subject_id = bs.subject_id
JOIN catalog c ON bs.book_id = c.book_id
ORDER BY s.subject_name, c.title;