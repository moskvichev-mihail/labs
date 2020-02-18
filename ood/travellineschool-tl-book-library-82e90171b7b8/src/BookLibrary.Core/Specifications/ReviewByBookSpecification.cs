using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    sealed class ReviewByBookSpecification : BaseSpecification<Review>
    {
        public ReviewByBookSpecification(int bookId)
        {
            AddInclude(r => r.Book);
            AddInclude(r => r.User);

            SetSelectingCriteria(r => r.BookId == bookId);
            SetSortingCriteria(r => r.CreationDate, OrderBy.Descending);
        }
    }
}
