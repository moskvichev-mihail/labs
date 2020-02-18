﻿// <auto-generated />
using BookLibrary.Core.DomainModels;
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
    [Migration("20180607184551_AddReview")]
    partial class AddReview
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.0.3-rtm-10026")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Book", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Author")
                        .HasMaxLength(255);

                    b.Property<string>("BigPictureUri");

                    b.Property<DateTime>("CreationDate");

                    b.Property<string>("Description");

                    b.Property<int>("GenreId");

                    b.Property<int>("Issued");

                    b.Property<int>("LibraryId");

                    b.Property<string>("Name")
                        .HasMaxLength(255);

                    b.Property<DateTime>("ReceiptDate");

                    b.Property<string>("SmallPictureUri");

                    b.Property<int>("Status");

                    b.HasKey("Id");

                    b.HasIndex("GenreId");

                    b.HasIndex("LibraryId");

                    b.ToTable("Book");
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

                    b.Property<int>("BookId");

                    b.Property<DateTime>("DateOfReturn");

                    b.Property<DateTime>("IssuanceDate");

                    b.Property<int>("UserId");

                    b.HasKey("Id");

                    b.HasIndex("BookId");

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
                    b.HasOne("BookLibrary.Core.DomainModels.Genre", "Genre")
                        .WithMany()
                        .HasForeignKey("GenreId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("BookLibrary.Core.DomainModels.Library", "Library")
                        .WithMany("Books")
                        .HasForeignKey("LibraryId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("BookLibrary.Core.DomainModels.Issuance", b =>
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
