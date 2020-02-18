using System;
using System.Collections.Generic;
using System.Linq;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Dto;
using BookLibrary.Core.Exceptions;
using BookLibrary.Core.Interfaces;
using BookLibrary.Core.Models;
using BookLibrary.Core.Specifications;

namespace BookLibrary.Core.Services
{
    public class BookService : IBookService
    {
        private readonly IRepository<Book> _bookRepository;
        private readonly IRepository<Library> _libraryRepository;
        private readonly IRepository<BookGenre> _bookGenreRepository;
        private readonly IRepository<BookAuthor> _bookAuthorRepository;
        private readonly IRepository<BookItem> _bookItemRepository;
        private readonly IRepository<Issuance> _issuanceRepository;

        public BookService(
            IRepository<Book> bookRepository,
            IRepository<Library> libraryRepository,
            IRepository<BookGenre> bookGenreRepository,
            IRepository<BookAuthor> bookAuthorRepository,
            IRepository<BookItem> bookItemRepository,
            IRepository<Issuance> issuanceRepository)
        {
            _bookRepository = bookRepository;
            _libraryRepository = libraryRepository;
            _bookGenreRepository = bookGenreRepository;
            _bookAuthorRepository = bookAuthorRepository;
            _bookItemRepository = bookItemRepository;
            _issuanceRepository = issuanceRepository;
        }

        public List<Library> GetLibraries()
        {
            return _libraryRepository.List(new AlLibrariesSpecification()).ToList();
        }

        public BookInfo GetBookInfo(int bookId)
        {
            var bookWithLibrarySpecification = new BookWithLibrarySpecification(bookId);
            Book book = _bookRepository.GetSingleBySpec(bookWithLibrarySpecification);
            if (book == null)
            {
                throw new BookNotFoundException(bookId);
            }

            List<BookGenre> bookGenres = _bookGenreRepository.List(new BookGenresSpecification(bookId)).ToList();
            List<BookAuthor> bookAuthors = _bookAuthorRepository.List(new BookAuthorsSpecification(bookId)).ToList();
            int booksQuantity = _bookItemRepository.GetRecordCountBySpec(new BookItemsByBookSpecification(bookId));

            return new BookInfo
            {
                Book = book,
                Authors = bookAuthors.Select(ba => ba.Author).ToList(),
                Genres = bookGenres.Select(bg => bg.Genre).ToList(),
                Quantity = booksQuantity
            };
        }

        public void AddBook(Book book)
        {
            _bookRepository.Add(book);
        }

        public List<BookInfo> GetBooksInfos(SearchBooksPattern searchBooksPattern)
        {
            var result = new List<BookInfo>();

            List<Book> books = _bookRepository.List(new AllBooksSpecification()).ToList();
            FilterByPattern(ref books, searchBooksPattern);
            SortByPattern(ref books, searchBooksPattern);
            books = books.Skip(((searchBooksPattern.Page - 1) * searchBooksPattern.Count)).Take(searchBooksPattern.Count).ToList();

            List<int> bookIds = books.Select(bg => bg.Id).ToList();
            List<BookAuthor> bookAuthors = _bookAuthorRepository.List(new BookAuthorsByBooksSpecification(bookIds)).ToList();
            foreach(Book book in books)
            {
                result.Add(new BookInfo
                {
                    Book = book,
                    Authors = bookAuthors.Where(ba => ba.BookId == book.Id).Select(ba => ba.Author).ToList()
                });
            }

            return result;
        }

        private void FilterByPattern(ref List<Book> books, SearchBooksPattern searchBooksPattern)
        {
            if (searchBooksPattern.GenreId != 0)
            {
                List<int> bookIds = _bookGenreRepository
                    .List(new BookGenresSpecification(searchBooksPattern.GenreId))
                    .Select(bg => bg.BookId)
                    .ToList();
                books = books.Where(b => bookIds.Contains(b.Id)).ToList();
            }
            if (searchBooksPattern.SearchString != "")
            {
                List<int> bookIds = books.Select(bg => bg.Id).ToList();
                List<BookAuthor> bookAuthors = _bookAuthorRepository.List(new BookAuthorsByBooksSpecification(bookIds)).ToList();
                List<int> filteredBookIds = bookAuthors
                    .Where(ba => ba.Book.Name.Contains(searchBooksPattern.SearchString)
                            || ba.Author.Name.Contains(searchBooksPattern.SearchString))
                    .Select(ba => ba.BookId)
                    .Distinct()
                    .ToList();
                books = books.Where(b => filteredBookIds.Contains(b.Id)).ToList();
            }
        }

        private void SortByPattern( ref List<Book> books, SearchBooksPattern searchBooksPattern)
        {
            if (searchBooksPattern.Sort.ToLower() == "popularity")
            {
                var bookIds = books.Select(b => b.Id).ToList();
                Dictionary<int, int> bookQuantityById = _issuanceRepository
                    .List(new IssuancesByBooksSpecification(bookIds))
                    .GroupBy(i => i.BookItem.BookId)
                    .ToDictionary(g => g.Key, g => g.Count());

                if (searchBooksPattern.OrderBy == OrderBy.Ascending)
                {
                    List<Book> temp = books;
                    temp = bookQuantityById
                        .OrderBy(g => g.Value)
                        .Select(p => temp.First(b => b.Id == p.Key))
                        .ToList();
                    books = temp;
                }
                else
                {
                    List<Book> temp = books;
                    temp = bookQuantityById
                        .OrderByDescending(g => g.Value)
                        .Select(p => temp.First(b => b.Id == p.Key))
                        .ToList();
                    books = temp;
                }
            }
            else
            {
                if (searchBooksPattern.OrderBy == OrderBy.Ascending)
                {
                    books = books.OrderBy(b => b.ReceiptDate).ToList();
                }
                else
                {
                    books = books.OrderByDescending(b => b.ReceiptDate).ToList();
                }
            }
        }

        public int GetBooksAmount(string searchString, int genreId)
        {
            return _bookRepository.GetRecordCountBySpec(new BooksCountSpecification(searchString, genreId));
        }

        public List<Book> SearchBooks(string searchStirng, int take)
        {
            return _bookRepository.List(new SearchSpecification(searchStirng, take)).ToList();
        }

        public List<BookInfo> GetSimilarBooksInfos(int take, List<int> authorIds)
        {
            var result = new List<BookInfo>();

            List<BookAuthor> bookAutors = _bookAuthorRepository.List(new BookAuthorByAuthorsSpecification(authorIds)).ToList();
            var bookInfos = bookAutors
                .GroupBy(ba => ba.BookId)
                .Select(g => new BookInfo
                {
                    Book = g.First().Book,
                    Authors = g.Select(ba => ba.Author).ToList()
                }).ToList();

            var rand = new Random();
            for (int i = 0; i < take; i++)
            {
                int bookInfosCount = bookInfos.Count;
                if (bookInfosCount == 0)
                    break;
                int randomNumber = rand.Next(bookInfosCount);
                BookInfo bookInfo = bookInfos[randomNumber];
                result.Add(bookInfo);
                bookInfos.RemoveAt(randomNumber);
            }

            return result;
        }

        public List<Book> GetPreOrderedBooks(int take)
        {
            return _bookRepository.List(new PreOrderedBooksSpecification(take)).ToList();
        }

        public List<Book> GetLastBooks(int take)
        {
            return _bookRepository.List(new LastBooksSpecification(take)).ToList();
        }

        public void Edit(Book book)
        {
            _bookRepository.Update(book);
        }

        public void AddBookItem(int bookId)
        {
            var bookItem = new BookItem
            {
                BookId = bookId
            };

            _bookItemRepository.Add(bookItem);
        }

        public void AddBookItem(int bookId, int newBookItemQuantity)
        {
            var result = new List<BookItem>();
            for (int i = 0; i < newBookItemQuantity; i++)
            {
                result.Add(new BookItem
                {
                    BookId = bookId
                });
            }

            _bookItemRepository.AddRange(result);
        }

        public int? GetFreeBookItemId(int bookId)
        {
            int? result = null;

            List<BookItem> bookItems = _bookItemRepository.List(new BookItemsByBookSpecification(bookId)).ToList();
            List<int> bookItemIds = bookItems.Select(bi => bi.Id).ToList();
            List<int> bookItemIdsOnHands = _issuanceRepository
                .List(new IssuancesByBookItemsSpecification(bookItemIds))
                .Select(i => i.BookItemId)
                .ToList();
            List<int> freeBookItemIds = bookItemIds.Except(bookItemIdsOnHands).ToList();
            if (freeBookItemIds.Any())
            {
                result = freeBookItemIds.First();
            }

            return result;
        }

    }
}
