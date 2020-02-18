using System.Collections.Generic;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class IssuancesByBooksSpecification : BaseSpecification<Issuance>
    {
        public IssuancesByBooksSpecification(List<int> bookIds)
            :base()
        {
            AddInclude(i => i.BookItem);
            SetSelectingCriteria(i => bookIds.Contains(i.BookItem.BookId));
        }
    }
}
