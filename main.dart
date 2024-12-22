// Library Management System

void main() {
  // Creating books
  Book book1 = Book("2020", "Summer's Ville", "101", true);
  Book book2 = Book("2021", "Will Jack", "102", true);

  // Creating a library instance and adding books
  Library library = Library();
  library.addBook(book1);
  library.addBook(book2);

  // Displaying all available books
  library.displayBookList();

  // Creating a member
  Member member1 = Member("Loan Member 1", "M01");

  // Member borrows a book
  print("\n<<<<<<<<<<<<<< Loan Book >>>>>>>>>>>>>>>>");
  library.loanBook(book1, member1);

  // Displaying loaned books
  library.displayLoanedBooks();

  // Returning the book
  print("\n<<<<<<<<<<<<<< Return Book >>>>>>>>>>>>>>>>");
  library.returnBook(book1);
  library.displayBookList();
}

// Book Class
class Book {
  String title;
  String author;
  String isbn;
  bool isAvailable;

  // Constructor
  Book(this.title, this.author, this.isbn, this.isAvailable);
}

// Library Class
class Library {
  List<Book> books = [];
  List<Loan> loans = [];

  // Method to loan a book
  void loanBook(Book book, Member member) {
    if (book.isAvailable) {
      book.isAvailable = false;
      loans.add(Loan(book, member, DateTime.now()));
      print("${book.title} has been loaned to ${member.name}.");
    } else {
      print("${book.title} is not available.");
    }
  }

  // Method to return a book
  void returnBook(Book book) {
    for (var loan in loans) {
      if (loan.book == book && loan.returnDate == null) {
        loan.returnBook();
        print("${book.title} has been returned.");
        return;
      }
    }
    print("${book.title} was not loaned out.");
  }

  // Method to add a book
  void addBook(Book book) {
    books.add(book);
  }

  // Display all available books
  void displayBookList() {
    print("\n----------------- All Available Books ----------------------");
    for (var book in books) {
      print(
          "Title: ${book.title}, Author: ${book.author}, ISBN: ${book.isbn}, Available: ${book.isAvailable}");
    }
  }

  // Display loaned books
  void displayLoanedBooks() {
    print("\n----------------- Loaned Books ----------------------");
    for (var loan in loans) {
      if (loan.returnDate == null) {
        print(
            "Title: ${loan.book.title}, Borrowed by: ${loan.member.name}, Loan Date: ${loan.loanDate}");
      }
    }
  }
}

// Member Class
class Member {
  String name;
  String memberId;

  // Constructor
  Member(this.name, this.memberId);
}

// Loan Class
class Loan {
  Book book;
  Member member;
  DateTime loanDate;
  DateTime? returnDate;

  // Constructor
  Loan(this.book, this.member, this.loanDate, [this.returnDate]);

  // Method to return the book
  void returnBook() {
    returnDate = DateTime.now();
    book.isAvailable = true;
  }
}
