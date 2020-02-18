using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class SearchSpecification : BaseSpecification<Book>
    {
        public SearchSpecification(string searchString, int take)
        {
            //SetSelectingCriteria(x => x.Author.Contains(searchString) || x.Name.Contains(searchString));
            //SetSortingCriteria(x => x.Issued, OrderBy.Descending);
            SetSkipTakeCriteria(0, take);
        }
    }
}
