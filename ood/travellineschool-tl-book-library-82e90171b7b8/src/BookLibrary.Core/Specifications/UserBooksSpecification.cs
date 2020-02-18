using System;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Models;

namespace BookLibrary.Core.Specifications
{
    sealed class UserBooksSpecification : BaseSpecification<Issuance>
    {
        public UserBooksSpecification(int userId)
        {
            //AddInclude(i => i.Book);
            AddInclude(i => i.User);
            SetSelectingCriteria(i => i.UserId == userId && !i.BookIsReturned);
            SetSortingCriteria(i => i.DateOfReturn, OrderBy.Ascending);
        }
    }
}
