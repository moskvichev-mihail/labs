using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class BookGenresSpecification : BaseSpecification<BookGenre>
    {
        public BookGenresSpecification( int bookId )
        {
            AddInclude(bg => bg.Genre);
            SetSelectingCriteria(bg => bg.BookId == bookId);
        }
    }
}
