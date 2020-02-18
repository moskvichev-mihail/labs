using Microsoft.EntityFrameworkCore;

namespace rip.Models
{
    public class BlogContext : DbContext
    {
        
        public DbSet<News> News { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Comments> Comments { get; set; }
 
        public BlogContext(DbContextOptions options) : base(options)
        {
            Database.EnsureCreated();
        }
    }
}