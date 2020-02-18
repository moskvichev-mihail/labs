namespace rip.Models
{
    public class Comments
    {
        public int CommentsId { get; set; }
        public User Author { get; set; }

        public int NewsId { get; set; }
        public News News { get; set; }

        public string TextContent { get; set; }
    }
}