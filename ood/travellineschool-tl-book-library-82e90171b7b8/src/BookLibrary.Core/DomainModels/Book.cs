using System;
using BookLibrary.Core.Data;

namespace BookLibrary.Core.DomainModels
{
    public class Book : BaseEntity
    {
        public Book()
        {
            CreationDate = DateTime.Now;
        }

        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime ReceiptDate { get; set; }
        public int LibraryId { get; set; }
        public Library Library { get; set; }
        public string PictureUri { get; set; }
    }
}
