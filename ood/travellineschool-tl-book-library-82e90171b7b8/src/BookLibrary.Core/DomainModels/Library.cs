using System.Collections.Generic;
using BookLibrary.Core.Data;

namespace BookLibrary.Core.DomainModels
{
    public class Library : BaseEntity
    {
        public string Name { get; set; }

        private ICollection<Book> _books;
        public virtual ICollection<Book> Books => _books ?? (_books = new List<Book>());
    }
}
