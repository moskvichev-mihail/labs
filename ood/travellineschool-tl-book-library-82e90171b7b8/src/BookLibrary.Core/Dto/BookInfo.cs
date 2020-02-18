using System;
using System.Collections.Generic;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Dto
{
    public class BookInfo
    {
        public Book Book { get; set; }
        public List<Genre> Genres { get; set; }
        public List<Author> Authors { get; set; }
        public int Quantity { get; set; }

        public object Select()
        {
            throw new NotImplementedException();
        }
    }
}
