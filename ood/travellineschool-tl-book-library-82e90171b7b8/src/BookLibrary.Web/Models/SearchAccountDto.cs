using System.Runtime.Serialization;

namespace BookLibrary.Web.Models
{
    [DataContract]
    public class SearchAccountDto
    {
        private int _page;
        private int _count;
        private int _userId;

        [DataMember(Name = "page")]
        public int Page
        {
            get
            {
                return _page <= 0 ? 1 : _page;
            }
            set { _page = value; }
        }

        [DataMember(Name = "userId")]
        public int UserId
        {
            get
            {
                return _userId <= 0 ? 0 : _userId;
            }
            set { _userId = value; }
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
