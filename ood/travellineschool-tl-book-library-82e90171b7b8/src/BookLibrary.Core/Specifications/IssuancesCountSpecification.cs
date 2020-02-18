using System;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    sealed class IssuancesCountSpecification : BaseSpecification<Issuance>
    {
        public IssuancesCountSpecification(int userId)
        {
            SetSelectingCriteria(i => i.UserId == userId && i.BookIsReturned);
        }
    }
}
