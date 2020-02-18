using System.Collections.Generic;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Dto;
using BookLibrary.Core.Interfaces;
using BookLibrary.Web.Mappers;
using BookLibrary.Web.Models;
using BookLibrary.Web.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookLibrary.Web.Controllers
{
    [Authorize]
    [Route("Catalog")]
    public class CatalogController : Controller
    {
        private readonly IBookService _bookService;
        private readonly IGenreService _genreService;


        public CatalogController(IBookService bookService, IGenreService catalogService)
        {
            _bookService = bookService;
            _genreService = catalogService;
        }

        [HttpGet]
        [HttpPost]
        public IActionResult Index(SearchCatalogDto searchCatalogDto)
        {
            List<BookInfo> booksInfos = _bookService.GetBooksInfos(searchCatalogDto.Map());
            List<Genre> genres = _genreService.GetGenres();
            var bookCount = _bookService.GetBooksAmount(searchCatalogDto.SearchString, searchCatalogDto.GenreId);
            var maxPage = bookCount % searchCatalogDto.Count == 0 ? bookCount / searchCatalogDto.Count : bookCount / searchCatalogDto.Count + 1;
            CatalogIndexViewModel viewModel = new CatalogIndexViewModel
            {
                BooksInfos = booksInfos,
                Genres = genres,
                Sort = searchCatalogDto.Sort,
                OrderBy = searchCatalogDto.OrderBy,
                Page = searchCatalogDto.Page,
                GenreId = searchCatalogDto.GenreId,
                MaxPage = maxPage,
                SearchString = searchCatalogDto.SearchString
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
