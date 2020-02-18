using System.Collections.Generic;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Web.ViewModels
{
    public class HomeIndexViewModel
    {
        public List<Book> PopularBooks { get; set; }
        public List<Book> LastBooks { get; set; }
        public List<Book> PreOrderedBooks { get; set; }
    }
}
