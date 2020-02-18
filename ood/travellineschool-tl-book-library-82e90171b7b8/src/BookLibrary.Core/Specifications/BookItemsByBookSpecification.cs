using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class BookItemsByBookSpecification : BaseSpecification<BookItem>
    {
        public BookItemsByBookSpecification(int bookId)
            : base(bi => bi.BookId == bookId)
        {
        }
    }
}
