using System.Collections.Generic;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Interfaces;
using BookLibrary.Web.Models;
using BookLibrary.Web.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookLibrary.Web.Controllers
{
    [Route("")]
    [Authorize]
    public class HomeController : Controller
    {
        private readonly IBookService _bookService;

        public HomeController(IBookService bookService)
        {
            _bookService = bookService;
        }

        [HttpGet]
        [HttpPost]
        public IActionResult Index(SearchCatalogDto searchCatalogDto)
        {
            //List<Book> popularBooks = _bookService.GetLastPopularBooks(6);
            List<Book> lastBooks = _bookService.GetLastBooks(6);
            List<Book> PreOrderedBooks = _bookService.GetPreOrderedBooks(6);

            HomeIndexViewModel viewModel = new HomeIndexViewModel
            {
                //PopularBooks = popularBooks,
                LastBooks = lastBooks,
                PreOrderedBooks = PreOrderedBooks
            };
            return View(viewModel);
        }

        [HttpGet("Error")]
        public IActionResult Error()
        {
            return View();
        }
    }
}
