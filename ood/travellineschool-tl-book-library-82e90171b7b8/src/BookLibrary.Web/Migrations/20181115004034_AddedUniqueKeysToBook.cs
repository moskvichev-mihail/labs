using Microsoft.EntityFrameworkCore.Migrations;
using System;
using System.Collections.Generic;

namespace BookLibrary.Web.Migrations
{
    public partial class AddedUniqueKeysToBook : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_BookGenre_GenreId",
                table: "BookGenre");

            migrationBuilder.DropIndex(
                name: "IX_BookAuthor_AuthorId",
                table: "BookAuthor");

            migrationBuilder.CreateIndex(
                name: "IX_BookGenre_GenreId_BookId",
                table: "BookGenre",
                columns: new[] { "GenreId", "BookId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_BookAuthor_AuthorId_BookId",
                table: "BookAuthor",
                columns: new[] { "AuthorId", "BookId" },
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_BookGenre_GenreId_BookId",
                table: "BookGenre");

            migrationBuilder.DropIndex(
                name: "IX_BookAuthor_AuthorId_BookId",
                table: "BookAuthor");

            migrationBuilder.CreateIndex(
                name: "IX_BookGenre_GenreId",
                table: "BookGenre",
                column: "GenreId");

            migrationBuilder.CreateIndex(
                name: "IX_BookAuthor_AuthorId",
                table: "BookAuthor",
                column: "AuthorId");
        }
    }
}
