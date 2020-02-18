using System.Collections.Generic;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class IssuancesByBookItemsSpecification : BaseSpecification<Issuance>
    {
        public IssuancesByBookItemsSpecification(List<int> bookItemIds)
            :base(i => bookItemIds.Contains(i.BookItemId) && !i.BookIsReturned)
        {
        }
    }
}
