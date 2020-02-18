using BookLibrary.Core.Data;

namespace BookLibrary.Core.DomainModels
{
    public class BookItem : BaseEntity
    {
        public int BookId { get; set; }
        public Book Book { get; set; }
    }
}
