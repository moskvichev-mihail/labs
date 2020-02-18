using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class PreOrderedBooksSpecification : BaseSpecification<Book>
    {
        public PreOrderedBooksSpecification(int take)
        {
            //SetSelectingCriteria(b => b.Status == BookStatus.PreOrder);
            SetSortingCriteria(b => b.CreationDate, OrderBy.Descending);
            SetSkipTakeCriteria(0, take);
        }
    }

}
