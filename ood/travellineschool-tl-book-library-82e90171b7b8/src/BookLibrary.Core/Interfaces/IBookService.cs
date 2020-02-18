using System.Collections.Generic;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Dto;
using BookLibrary.Core.Models;

namespace BookLibrary.Core.Interfaces
{
    public interface IBookService
    {
        BookInfo GetBookInfo(int bookId);
        void AddBook(Book book);
        List<BookInfo> GetBooksInfos(SearchBooksPattern searchBooksPattern);
        int GetBooksAmount(string searchString, int genreId);
        List<Book> SearchBooks(string searchStirng, int take);
        List<BookInfo> GetSimilarBooksInfos(int take, List<int> authorIds);
        List<Book> GetLastBooks(int take);
        List<Book> GetPreOrderedBooks(int take);
        List<Library> GetLibraries();
        void Edit(Book book);
        void AddBookItem(int bookId);
        void AddBookItem(int bookId, int newBookItemQuantity);
        int? GetFreeBookItemId(int bookId);
    }
}
