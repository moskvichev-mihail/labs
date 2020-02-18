using System.Runtime.Serialization;

namespace BookLibrary.Web.Models
{
    [DataContract]
    public class BookDto
    {
        [DataMember(Name = "id")]
        public int Id { get; set; }

        [DataMember(Name = "name")]
        public string Name { get; set; }

        [DataMember(Name = "author")]
        public string Author { get; set; }

        [DataMember(Name = "decription")]
        public string Description { get; set; }

        [DataMember(Name = "receiptDate")]
        public string ReceiptDate { get; set; }

        [DataMember(Name = "issued")]
        public int Issued { get; set; }

        [DataMember(Name = "smallPictureUri")]
        public string SmallPictureUri { get; set; }
    }
}
