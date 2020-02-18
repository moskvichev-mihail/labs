using System.Collections.Generic;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Interfaces
{
    public interface IGenreService
    {
        List<Genre> GetGenres();
    }
}
