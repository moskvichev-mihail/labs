using BookLibrary.Core.DomainModels;
using BookLibrary.Web.Models;

namespace BookLibrary.Web.Mappers
{
    public static class LibraryMapper
    {
        public static LibraryDto Map(this Library library)
        {
            return new LibraryDto
            {
                Id = library.Id,
                Name = library.Name
            };
        }
    }
}
