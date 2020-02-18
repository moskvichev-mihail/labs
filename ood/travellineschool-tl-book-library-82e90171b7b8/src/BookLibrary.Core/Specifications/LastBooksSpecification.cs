using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class LastBooksSpecification : BaseSpecification<Book>
    {
        public LastBooksSpecification(int take)
        {
            SetSortingCriteria(b => b.CreationDate, OrderBy.Descending);
            SetSkipTakeCriteria(0, take);
        }
    }

}
