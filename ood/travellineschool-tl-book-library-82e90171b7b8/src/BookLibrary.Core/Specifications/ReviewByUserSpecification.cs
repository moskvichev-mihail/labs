using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    sealed class ReviewByUserSpecification : BaseSpecification<Review>
    {
        public ReviewByUserSpecification(int userId)
        {
            AddInclude(r => r.Book);
            AddInclude(r => r.User);

            SetSelectingCriteria(r => r.UserId == userId);
            SetSortingCriteria(r => r.CreationDate, OrderBy.Descending);
        }
    }
}
