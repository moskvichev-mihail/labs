using System.Runtime.Serialization;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Web.Models
{
    [DataContract]
    public class SearchCatalogDto
    {
        private int _page;
        private int _genreId;
        private int _count;
        private string _sort;
        private OrderBy _orderBy;
        private string _searchString;

        [DataMember(Name = "searchString")]
        public string SearchString
        {
            get
            {
                return _searchString ?? "";
            }
            set { _searchString = value; }
        }

        [DataMember(Name = "page")]
        public int Page
        {
            get
            {
                return _page <= 0 ? 1 : _page;
            }
            set { _page = value; }
        }

        [DataMember(Name = "genreId")]
        public int GenreId
        {
            get
            {
                return _genreId <= 0 ? 0 : _genreId;
            }
            set { _genreId = value; }
        }

        [DataMember(Name = "status")]
        public BookStatus Status { get; set; }

        [DataMember(Name = "sort")]
        public string Sort
        {
            get
            {
                return _sort ?? "receiptDate";
            }
            set { _sort = value; }
        }

        [DataMember(Name = "orderBy")]
        public OrderBy OrderBy
        {
            get
            {
                return _orderBy == OrderBy.Ascending ? OrderBy.Ascending : OrderBy.Descending;
            }
            set { _orderBy = value; }
        }

        [DataMember(Name = "count")]
        public int Count
        {
            get
            {
                return _count <= 0 ? 12 : _count;
            }
            set
            {
                _count = value;
            }
        }
    }
}
