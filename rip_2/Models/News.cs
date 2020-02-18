using System.Collections.Generic;

namespace rip.Models
{
    public class News
    {
        public int NewsId { get; set; }
        public string Name { get; set; }
        public string Text { get; set; }
        
        public int AuthorId { get; set; }
        public User Author { get; set; }

        public List<Comments> Comments{ get; set; }
    }
}