using System;
using System.IO;
using BookLibrary.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace BookLibrary.Web
{
    public class DesignTimeRepositoryContextFactory :
        IDesignTimeDbContextFactory<BookLibraryContext>
    {
        public BookLibraryContext CreateDbContext(string[] args)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json")
                .AddJsonFile($"appsettings.{Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT")}.json", true)
                .AddEnvironmentVariables();

            var config = builder.Build();
            var connectionString = config.GetConnectionString("BookLibraryConnection");
            var optionsBuilder = new DbContextOptionsBuilder<BookLibraryContext>();
            optionsBuilder.UseSqlServer(connectionString, x => x.MigrationsAssembly("BookLibrary.Web"));
            return new BookLibraryContext(optionsBuilder.Options);
        }
    }
}
