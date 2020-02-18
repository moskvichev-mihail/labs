using System.Collections.Generic;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Interfaces;
using BookLibrary.Web.Mappers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookLibrary.Web.Controllers
{
    [Authorize]
    public class SearchController : Controller
    {
        private readonly IBookService _bookService;

        public SearchController(IBookService bookService)
        {
            _bookService = bookService;
        }

        [Produces("application/json")]
        [Route("api/books")]
        [HttpPost]
        public IActionResult SearchBooks(string searchString)
        {
            List<Book> books = new List<Book>() { };
            if (!string.IsNullOrEmpty(searchString))
            {
                books = _bookService.SearchBooks(searchString, 6);
            }
            
            return Ok(books.ConvertAll(x => x.Map()));;
        }
    }
}
