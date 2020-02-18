using BookLibrary.Core.DomainModels;
using BookLibrary.Web.Models;

namespace BookLibrary.Web.Mappers
{
    public static class GenreMapper
    {
        public static GenreDto Map(this Genre genre)
        {
            return new GenreDto
            {
                Id = genre.Id,
                Name = genre.Name
            };
        }
    }
}
