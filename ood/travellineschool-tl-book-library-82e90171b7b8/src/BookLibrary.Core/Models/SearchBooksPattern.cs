using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Models
{
    public class SearchBooksPattern
    {
        public int Page { get; set; }
        public int GenreId { get; set; }
        public BookStatus Status { get; set; }
        public string Sort { get; set; }
        public OrderBy OrderBy { get; set; }
        public int Count { get; set; }
        public string SearchString { get; set; }
    }
}
