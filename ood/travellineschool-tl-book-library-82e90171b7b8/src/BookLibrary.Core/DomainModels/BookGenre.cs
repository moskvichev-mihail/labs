﻿using BookLibrary.Core.Data;

namespace BookLibrary.Core.DomainModels
{
    public class BookGenre : BaseEntity
    {
        public int BookId {get; set;}
        public Book Book { get; set; }
        public int GenreId { get; set; }
        public Genre Genre { get; set; }
    }
}
