using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    public sealed class BookWithLibrarySpecification : BaseSpecification<Book>
    {
        public BookWithLibrarySpecification(int bookId)
            : base(b => b.Id == bookId)
        {
            AddInclude(b => b.Library);
        }
    }
}
