using System.Collections.Generic;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class BookAuthorByAuthorsSpecification: BaseSpecification<BookAuthor>
    {
        public BookAuthorByAuthorsSpecification(List<int> authorIds)
        {
            AddInclude(ba => ba.Book);
            SetSelectingCriteria(ba => authorIds.Contains(ba.AuthorId));
        }
    }
}
