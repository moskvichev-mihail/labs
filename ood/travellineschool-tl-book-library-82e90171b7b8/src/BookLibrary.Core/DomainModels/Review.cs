using System;
using BookLibrary.Core.Data;

namespace BookLibrary.Core.DomainModels
{
    public class Review : BaseEntity
    {
        public Review()
        {
            CreationDate = DateTime.Now;
        }

        public string Description { get; set; }
        public int Rate { get; set; }
        public int UserId { get; set; }
        public int BookId { get; set; }
        public Book Book { get; set; }
        public User User { get; set; }
        public DateTime CreationDate { get; set; }
    }
}
