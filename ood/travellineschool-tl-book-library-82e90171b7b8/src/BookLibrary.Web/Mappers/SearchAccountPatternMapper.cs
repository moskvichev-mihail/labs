using BookLibrary.Core.Models;
using BookLibrary.Web.Models;

namespace BookLibrary.Web.Mappers
{
    public static class SearchAccountPatternMapper
    {
        public static SearchAccountPattern Map(this SearchAccountDto searchAccountDto)
        {
            return new SearchAccountPattern
            {
                Page = searchAccountDto.Page,
                Count = searchAccountDto.Count,
                UserId = searchAccountDto.UserId
            };
        }
    }
}
