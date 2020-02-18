﻿// <auto-generated />
using BookLibrary.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.EntityFrameworkCore.Storage.Internal;
using System;

namespace BookLibrary.Web.Migrations
{
    [DbContext(typeof(BookLibraryContext))]
    partial class BookLibraryContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.0.3-rtm-10026")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Author", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Name");

                    b.HasKey("Id");

                    b.ToTable("Author");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Book", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<DateTime>("CreationDate");

                    b.Property<string>("Description");

                    b.Property<int>("LibraryId");

                    b.Property<string>("Name")
                        .HasMaxLength(255);

                    b.Property<string>("PictureUri");

                    b.Property<DateTime>("ReceiptDate");

                    b.HasKey("Id");

                    b.HasIndex("LibraryId");

                    b.ToTable("Book");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.BookAuthor", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("AuthorId");

                    b.Property<int>("BookId");

                    b.HasKey("Id");

                    b.HasIndex("BookId");

                    b.HasIndex("AuthorId", "BookId")
                        .IsUnique();

                    b.ToTable("BookAuthor");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.BookGenre", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("BookId");

                    b.Property<int>("GenreId");

                    b.HasKey("Id");

                    b.HasIndex("BookId");

                    b.HasIndex("GenreId", "BookId")
                        .IsUnique();

                    b.ToTable("BookGenre");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.BookItem", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("BookId");

                    b.HasKey("Id");

                    b.HasIndex("BookId");

                    b.ToTable("BookItem");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Genre", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Name")
                        .HasMaxLength(255);

                    b.HasKey("Id");

                    b.ToTable("Genre");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Issuance", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<bool>("BookIsReturned");

                    b.Property<int>("BookItemId");

                    b.Property<DateTime>("DateOfReturn");

                    b.Property<DateTime>("IssuanceDate");

                    b.Property<int>("UserId");

                    b.HasKey("Id");

                    b.HasIndex("BookItemId");

                    b.HasIndex("UserId");

                    b.ToTable("Issuance");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Library", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Name")
                        .HasMaxLength(255);

                    b.HasKey("Id");

                    b.ToTable("Library");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Review", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("BookId");

                    b.Property<DateTime>("CreationDate");

                    b.Property<string>("Description");

                    b.Property<int>("Rate");

                    b.Property<int>("UserId");

                    b.HasKey("Id");

                    b.HasIndex("BookId");

                    b.HasIndex("UserId");

                    b.ToTable("Review");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Role", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Name")
                        .HasMaxLength(255);

                    b.HasKey("Id");

                    b.ToTable("Role");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Email")
                        .HasMaxLength(255);

                    b.Property<string>("Password")
                        .HasMaxLength(255);

                    b.Property<int?>("RoleId");

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("User");
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Book", b =>
                {
                    b.HasOne("BookLibrary.Core.DomainModels.Library", "Library")
                        .WithMany("Books")
                        .HasForeignKey("LibraryId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.BookAuthor", b =>
                {
                    b.HasOne("BookLibrary.Core.DomainModels.Author", "Author")
                        .WithMany()
                        .HasForeignKey("AuthorId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("BookLibrary.Core.DomainModels.Book", "Book")
                        .WithMany()
                        .HasForeignKey("BookId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.BookGenre", b =>
                {
                    b.HasOne("BookLibrary.Core.DomainModels.Book", "Book")
                        .WithMany()
                        .HasForeignKey("BookId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("BookLibrary.Core.DomainModels.Genre", "Genre")
                        .WithMany()
                        .HasForeignKey("GenreId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.BookItem", b =>
                {
                    b.HasOne("BookLibrary.Core.DomainModels.Book", "Book")
                        .WithMany()
                        .HasForeignKey("BookId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Issuance", b =>
                {
                    b.HasOne("BookLibrary.Core.DomainModels.BookItem", "BookItem")
                        .WithMany()
                        .HasForeignKey("BookItemId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("BookLibrary.Core.DomainModels.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Review", b =>
                {
                    b.HasOne("BookLibrary.Core.DomainModels.Book", "Book")
                        .WithMany()
                        .HasForeignKey("BookId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("BookLibrary.Core.DomainModels.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.User", b =>
                {
                    b.HasOne("BookLibrary.Core.DomainModels.Role", "Role")
                        .WithMany("Users")
                        .HasForeignKey("RoleId");
                });
#pragma warning restore 612, 618
        }
    }
}
