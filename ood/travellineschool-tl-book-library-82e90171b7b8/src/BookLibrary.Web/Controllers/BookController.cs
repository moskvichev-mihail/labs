using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Claims;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Dto;
using BookLibrary.Core.Exceptions;
using BookLibrary.Core.Interfaces;
using BookLibrary.Web.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace BookLibrary.Web.Controllers
{
    [Route("book")]
    [Authorize]
    public class BookController : Controller
    {
        private readonly IBookService _bookService;
        private readonly IIssuanceService _issuanceService;
        private readonly IReviewService _reviewService;
        private readonly IGenreService _genreService;
        private readonly IHostingEnvironment _appEnvironment;

        public BookController(IBookService bookService, IIssuanceService issuanceService, IReviewService reviewService, IGenreService genreService,
            IHostingEnvironment appEnvironment)
        {
            _bookService = bookService;
            _issuanceService = issuanceService;
            _reviewService = reviewService;
            _genreService = genreService;
            _appEnvironment = appEnvironment;
        }

        [HttpGet]
        public IActionResult Index(int bookId)
        {
            BookInfo bookInfo;
            try
            {
                bookInfo = _bookService.GetBookInfo(bookId);
            }
            catch (BookNotFoundException e)
            {
                return RedirectToAction("Error", "Book", new { message = e.Message });
            }
            List<int> authorsIds = bookInfo.Authors.Select(a => a.Id).ToList();
            List<BookInfo> similarBooksInfos = _bookService.GetSimilarBooksInfos(6, authorsIds);
            List<Review> reviews = _reviewService.GetBookReviews(bookId);
            int rating = _reviewService.GetAverageRating(reviews);
            //SelectList genres = new SelectList(_genreService.GetGenres(), "Id", "Name", book.GenreId);
            SelectList libraries = new SelectList(_bookService.GetLibraries(), "Id", "Name", bookInfo.Book.LibraryId);
            DetailPageViewModel viewModel = new DetailPageViewModel
            {
                BookInfo = bookInfo,
                SimilarBooksInfos = similarBooksInfos,
                Reviews = reviews,
                Rating = rating,
                Libraries = libraries,
                Role = User.FindFirst(x => x.Type == ClaimsIdentity.DefaultRoleClaimType).Value
            };

            return View(viewModel);
        }

        [Produces("application/json")]
        [HttpPost]
        [Route("AddBooking")]
        public IActionResult AddBooking(int bookId)
        {
            int userId = Convert.ToInt32(User.FindFirst(x => x.Type == "id").Value, 10);
            BookInfo bookInfo = _bookService.GetBookInfo(bookId);
            if (bookInfo.Quantity == 0)
            {
                return Json(new { statusCode = "400", statusDescription = "Книги нет в наличии" });
            }

            int? bookItemId = _bookService.GetFreeBookItemId(bookId);
            if (bookItemId == null)
            {
                return Json(new { statusCode = "400", statusDescription = "Свободных книг пока нет" });
            }

            _issuanceService.AddIssuance(bookItemId.Value, userId);

            return Json(new { statusCode = "200", statusDescription = "Книга успешно добавлена" });
        }

        [HttpPost]
        [Route("AddReview")]
        public IActionResult AddReview(Review review)
        {
            int userId = Convert.ToInt32(User.FindFirst(x => x.Type == "id").Value, 10);
            review.UserId = userId;
            _reviewService.AddReview(review);
            return Redirect($"/book?bookId={review.BookId}");
        }

        [Authorize(Roles = "admin")]
        [HttpPost]
        [Route("Edit")]
        public RedirectResult Edit(Book book, IFormFile picture, int newBookItemQuantity)
        {
            if (picture != null)
            {
                SaveFile(book.PictureUri, picture);
            }

            _bookService.Edit(book);
            _bookService.AddBookItem(book.Id, newBookItemQuantity);
            return Redirect($"/book?bookId={book.Id}");
        }

        private void SaveFile(string path, in IFormFile file)
        {
            var fileStream = new FileStream(_appEnvironment.WebRootPath + path, FileMode.Create);
            file.CopyTo(fileStream);
            fileStream.Close();
        }

        [HttpGet("Error")]
        public IActionResult Error(string message)
        {
            @ViewBag.Message = message;
            return View();
        }
    }
}
