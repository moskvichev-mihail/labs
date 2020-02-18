using System.Collections.Generic;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Dto;

namespace BookLibrary.Web.ViewModels
{
    public class CatalogIndexViewModel
    {
        public List<BookInfo> BooksInfos { get; set; }
        public List<Genre> Genres { get; set; }
        public string Sort { get; set; }
        public OrderBy OrderBy { get; set; }
        public int GenreId { get; set; }
        public int Page { get; set; }
        public int MaxPage { get; set; }
        public string SearchString { get; set; }
    }
}
