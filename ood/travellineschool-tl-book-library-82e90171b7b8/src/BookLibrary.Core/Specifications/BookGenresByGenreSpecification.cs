using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    class BookGenresByGenreSpecification : BaseSpecification<BookGenre>
    {
        public BookGenresByGenreSpecification( int genreId )
        {
            SetSelectingCriteria(bg => bg.GenreId == genreId);
        }
    }
}
