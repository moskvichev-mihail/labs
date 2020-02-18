using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Web.ViewModels
{
    public class SearchViewModel
    {
        public List<Book> Books { get; set; }
    }
}
