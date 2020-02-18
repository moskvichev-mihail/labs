using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class BookAuthorsSpecification : BaseSpecification<BookAuthor>
    {
        public BookAuthorsSpecification( int bookId )
        {
            AddInclude(ba => ba.Author);
            SetSelectingCriteria(ba => ba.BookId == bookId);
        }
    }
}
