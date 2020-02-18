using System;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Models;

namespace BookLibrary.Core.Specifications
{
    sealed class UserHistorySpecification : BaseSpecification<Issuance>
    {
        public UserHistorySpecification(SearchAccountPattern searchAccountPattern)
        {
            //AddInclude(i => i.Book);
            AddInclude(i => i.User);
            SetSelectingCriteria(i => i.UserId == searchAccountPattern.UserId && i.BookIsReturned);
            SetSortingCriteria(i => i.DateOfReturn, OrderBy.Descending);
            SetSkipTakeCriteria(((searchAccountPattern.Page - 1) * searchAccountPattern.Count), searchAccountPattern.Count);
        }
    }
}
