using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class BooksCountSpecification : BaseSpecification<Book>
    {
        public BooksCountSpecification(string searchString, int genreId)
        {
            if (genreId != 0 && searchString != "")
            {
                //SetSelectingCriteria(b => b.GenreId == genreId && b.Author.Contains(searchString) || b.Name.Contains(searchString));
            }
            else if (genreId != 0)
            {
                //SetSelectingCriteria(b => b.GenreId == genreId);
            }
            else if (searchString != "")
            {
                //SetSelectingCriteria(x => x.Author.Contains(searchString) || x.Name.Contains(searchString));
            }
        }
    }
}
