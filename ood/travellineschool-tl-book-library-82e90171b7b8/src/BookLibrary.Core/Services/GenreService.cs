using System.Collections.Generic;
using System.Linq;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Interfaces;
using BookLibrary.Core.Specifications;

namespace BookLibrary.Core.Services
{
    public class GenreService : IGenreService
    {
        private readonly IRepository<Genre> _genreRepository;

        public GenreService(IRepository<Genre> genreRepository)
        {
            _genreRepository = genreRepository;
        }

        public List<Genre> GetGenres()
        {
            return _genreRepository.List(new AllGenresSpecification()).ToList();
        }

    }
}
