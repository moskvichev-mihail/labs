using BookLibrary.Core.Models;
using BookLibrary.Web.Models;

namespace BookLibrary.Web.Mappers
{
    public static class SearchBooksPatternMapper
    {
        public static SearchBooksPattern Map(this SearchCatalogDto searchCatalogDto)
        {
            return new SearchBooksPattern
            {
                Page = searchCatalogDto.Page,
                GenreId = searchCatalogDto.GenreId,
                Status = searchCatalogDto.Status,
                Sort = searchCatalogDto.Sort,
                OrderBy = searchCatalogDto.OrderBy,
                Count = searchCatalogDto.Count,
                SearchString = searchCatalogDto.SearchString
            };
        }
    }
}
