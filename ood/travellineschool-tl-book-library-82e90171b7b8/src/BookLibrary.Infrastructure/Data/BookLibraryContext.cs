using BookLibrary.Core.DomainModels;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace BookLibrary.Infrastructure.Data
{
    public class BookLibraryContext : DbContext
    {
        public BookLibraryContext(DbContextOptions<BookLibraryContext> options) : base(options)
        {
        }

        public DbSet<Book> Book { get; set; }
        public DbSet<Library> Library { get; set; }
        public DbSet<Genre> Genre { get; set; }
        public DbSet<Issuance> Issuance { get; set; }
        public DbSet<User> User { get; set; }
        public DbSet<Role> Role { get; set; }
        public DbSet<Review> Review { get; set; }
        public DbSet<BookItem> BookItem { get; set; }
        public DbSet<BookGenre> BookGenre { get; set; }
        public DbSet<Author> Author { get; set; }
        public DbSet<BookAuthor> BookAuthor { get; set; }


        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<Book>(ConfigureBook);
            builder.Entity<Library>(ConfigureLibrary);
            builder.Entity<Genre>(ConfigureGenre);
            builder.Entity<Issuance>(ConfigureIssuance);
            builder.Entity<User>(ConfigureUser);
            builder.Entity<Role>(ConfigureRole);
            builder.Entity<Review>(ConfigureReview);
            builder.Entity<BookGenre>(ConfigureBookGenre);
            builder.Entity<BookAuthor>(ConfigureBookAuthor);
        }

        private void ConfigureBookGenre(EntityTypeBuilder<BookGenre> builder)
        {
            builder.HasIndex(bg => new { bg.GenreId, bg.BookId }).IsUnique();
        }

        private void ConfigureBookAuthor(EntityTypeBuilder<BookAuthor> builder)
        {
            builder.HasIndex(ba => new { ba.AuthorId, ba.BookId }).IsUnique();
        }

        private void ConfigureReview(EntityTypeBuilder<Review> builder)
        {
        }

        private void ConfigureRole(EntityTypeBuilder<Role> builder)
        {
            builder.Property(x => x.Name).HasMaxLength(255);
        }

        private void ConfigureUser(EntityTypeBuilder<User> builder)
        {
            builder.Property(x => x.Email).HasMaxLength(255);
            builder.Property(x => x.Password).HasMaxLength(255);
        }

        private void ConfigureIssuance(EntityTypeBuilder<Issuance> builder)
        {

        }

        private void ConfigureGenre(EntityTypeBuilder<Genre> builder)
        {
            builder.Property(x => x.Name).HasMaxLength(255);
        }

        private void ConfigureBook(EntityTypeBuilder<Book> builder)
        {
            builder.Property(x => x.Name).HasMaxLength(255);
        }

        private void ConfigureLibrary(EntityTypeBuilder<Library> builder)
        {
            builder.Property(x => x.Name).HasMaxLength(255);
        }
    }
}
