using System;
using BookLibrary.Core.Data;

namespace BookLibrary.Core.DomainModels
{
    public class Issuance : BaseEntity
    {
        public int UserId { get; set; }
        public int BookItemId { get; set; }
        public BookItem BookItem { get; set; }
        public User User { get; set; }
        public DateTime IssuanceDate { get; set; } = DateTime.Now;
        public DateTime DateOfReturn { get; set; } = DateTime.Now.AddDays(15);
        public bool BookIsReturned { get; set; } = false;
    }
}
