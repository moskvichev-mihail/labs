using System.Collections.Generic;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class BookAuthorsByBooksSpecification : BaseSpecification<BookAuthor>
    {
        public BookAuthorsByBooksSpecification( List<int> bookIds )
        {
            AddInclude(ba => ba.Author);
            AddInclude(ba => ba.Book);
            SetSelectingCriteria(ba => bookIds.Contains(ba.BookId));
        }
    }
}
