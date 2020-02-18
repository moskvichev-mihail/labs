using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Claims;
using System.Threading.Tasks;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Interfaces;
using BookLibrary.Web.Mappers;
using BookLibrary.Web.Models;
using BookLibrary.Web.ViewModels;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace BookLibrary.Web.Controllers
{
    [Route("Account")]
    public class AccountController : Controller
    {
        private readonly IIssuanceService _issuanceService;
        private readonly IBookService _bookService;
        private readonly IGenreService _genreService;
        private readonly IUserService _userService;
        private readonly IReviewService _reviewService;
        private readonly IHostingEnvironment _appEnvironment;

        public AccountController(IIssuanceService issuanceService, IBookService bookService, IGenreService genreService, IUserService userService,
            IReviewService reviewService, IHostingEnvironment appEnvironment)
        {
            _issuanceService = issuanceService;
            _bookService = bookService;
            _genreService = genreService;
            _userService = userService;
            _reviewService = reviewService;
            _appEnvironment = appEnvironment;
        }

        [Route("Login")]
        [HttpGet]
        public IActionResult Login()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return View();
            }
        }

        [Route("Login")]
        [Produces("application/json")]
        [HttpPost]
        public async Task<IActionResult> Login(LoginModel model)
        {
            if (ModelState.IsValid)
            {
                User user = _userService.GetUser(model.Email, model.Password);
                if (user != null)
                {
                    await Authenticate(user);

                    return RedirectToAction("Index", "Home");
                }
                ModelState.AddModelError("", "Некорректные логин и(или) пароль");
            }
            return Json(new { statusCode = "400", statusDescription = "Неправильный email или пароль" });
        }

        private async Task Authenticate(User user)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimsIdentity.DefaultNameClaimType, user.Email),
                new Claim(ClaimsIdentity.DefaultRoleClaimType, user.Role?.Name),
                new Claim("id", user.Id.ToString())
            };

            ClaimsIdentity id = new ClaimsIdentity(claims, "ApplicationCookie", ClaimsIdentity.DefaultNameClaimType, ClaimsIdentity.DefaultRoleClaimType);
            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(id));
        }

        [Route("Logout")]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login", "Account");
        }

        [Authorize]
        [HttpGet]
        [Route("History")]
        public IActionResult History(SearchAccountDto searchAccountDto)
        {
            ViewBag.Role = User.FindFirst(x => x.Type == ClaimsIdentity.DefaultRoleClaimType).Value;
            searchAccountDto.UserId = Convert.ToInt32(User.FindFirst(x => x.Type == "id").Value, 10);

            List<Issuance> issuances = _issuanceService.GetHistory(searchAccountDto.Map());
            var issuanceAmount = _issuanceService.GetIssuanceQuantity(searchAccountDto.UserId);

            var viewModel = new AccountHistoryViewModel
            {
                MaxPage = issuanceAmount % searchAccountDto.Count == 0 ? issuanceAmount / searchAccountDto.Count : issuanceAmount / searchAccountDto.Count + 1,
                Page = searchAccountDto.Page,
                Issuances = issuances,
            };
            return View("~/Views/Account/History.cshtml", viewModel);
        }

        [Authorize]
        [HttpGet]
        [Route("MyBooks")]
        [Route("")]
        public IActionResult MyBooks()
        {
            ViewBag.Role = User.FindFirst(x => x.Type == ClaimsIdentity.DefaultRoleClaimType).Value;
            int userId = Convert.ToInt32(User.FindFirst(x => x.Type == "id").Value, 10);
            ViewBag.Issuances = _issuanceService.GetMyBooks(userId);

            return View("~/Views/Account/MyBooks.cshtml");
        }

        [Authorize]
        [HttpGet]
        [Route("MyReviews")]
        public IActionResult MyReviews()
        {
            ViewBag.Role = User.FindFirst(x => x.Type == ClaimsIdentity.DefaultRoleClaimType).Value;
            int userId = Convert.ToInt32(User.FindFirst(x => x.Type == "id").Value, 10);
            List<Review> reviews = _reviewService.GetUserReviews(userId);
            ViewBag.Reviews = reviews;
            return View("~/Views/Account/MyReview.cshtml");
        }

        [Authorize(Roles = "admin")]
        [HttpGet]
        [Route("Management")]
        public IActionResult Management()
        {
            ViewBag.Role = User.FindFirst(x => x.Type == ClaimsIdentity.DefaultRoleClaimType).Value;
            SelectList genres = new SelectList(_genreService.GetGenres(), "Id", "Name");
            SelectList libraries = new SelectList(_bookService.GetLibraries(), "Id", "Name");
            ViewBag.Libraries = libraries;
            ViewBag.Genres = genres;
            return View("~/Views/Account/Management.cshtml");
        }

        [Authorize]
        [HttpPost]
        [Route("Management")]
        public RedirectResult Management(Book book, IFormFile smallPicture, IFormFile bigPicture)
        {
            var smallPictureUri = CommonFunctions.CreatePictureUri("/images/books/small/", Guid.NewGuid().ToString(), Path.GetExtension(smallPicture.FileName));
            var bigPictureUri = CommonFunctions.CreatePictureUri("/images/books/big/", Guid.NewGuid().ToString(), Path.GetExtension(bigPicture.FileName));

            //book.SmallPictureUri = smallPictureUri;
            //book.BigPictureUri = bigPictureUri;

            SaveFile(smallPictureUri, smallPicture);
            SaveFile(bigPictureUri, bigPicture);
            // (book.Status == BookStatus.InStock && book.ReceiptDate == DateTime.MinValue)
            //
            //  book.ReceiptDate = DateTime.Now;
            //
            _bookService.AddBook(book);
            return Redirect("~/account/Management");
        }

        private void SaveFile(string path, in IFormFile file)
        {
            var fileStream = new FileStream(_appEnvironment.WebRootPath + path, FileMode.Create);
            file.CopyTo(fileStream);
            fileStream.Close();
        }

        [Authorize]
        [Produces("application/json")]
        [HttpPost]
        [Route("ReturnBook")]
        public IActionResult ReturnBook(Issuance issuance)
        {
            //Book book = _bookService.GetBook(issuance.BookId);
            //++book.Quantity;
            //book.Status = BookStatus.InStock;
            //_bookService.Edit(book);

            issuance.DateOfReturn = DateTime.Now;
            _issuanceService.UpdateIssuance(issuance);

            return Redirect("~/account/MyBooks");
        }

        [HttpGet("Error")]
        public IActionResult Error()
        {
            return View();
        }
    }
}
