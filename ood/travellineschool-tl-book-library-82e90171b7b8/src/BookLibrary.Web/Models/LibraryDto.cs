using System.Runtime.Serialization;

namespace BookLibrary.Web.Models
{
    [DataContract]
    public class LibraryDto
    {
        [DataMember(Name = "id")]
        public int Id { get; set; }

        [DataMember(Name = "name")]
        public string Name { get; set; }
    }
}
