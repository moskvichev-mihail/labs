using System;
using BookLibrary.Core.Data;
using BookLibrary.Core.Interfaces;
using BookLibrary.Core.Services;
using BookLibrary.Infrastructure.Data;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace BookLibrary.Web
{
    public class Startup
    {
        private IServiceCollection _services;

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureDevelopmentServices(IServiceCollection services)
        {
            // use in-memory database
            //ConfigureTestingServices(services);
        }

        public void ConfigureTestingServices(IServiceCollection services)
        {
            // use in-memory database
            services.AddDbContext<BookLibraryContext>(c =>
                c.UseInMemoryDatabase("BookLibrary"));

            ConfigureServices(services);
        }

        public void ConfigureProductionServices(IServiceCollection services)
        {

            ConfigureServices(services);
        }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<BookLibraryContext>(c =>
            {
                try
                {
                    c.UseSqlServer(Configuration.GetConnectionString("BookLibraryConnection"));
                }
                catch (Exception)
                {
                    //var message = ex.Message;
                }
            });

            services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
                .AddCookie(options => //CookieAuthenticationOptions
                {
                    options.LoginPath = new Microsoft.AspNetCore.Http.PathString("/Account/Login");
                });

            services.AddScoped(typeof(IRepository<>), typeof(EfRepository<>));

            services.AddScoped<IBookService, BookService>();

            services.AddScoped<IUserService, UserService>();

            services.AddScoped<IGenreService, GenreService>();

            services.AddScoped<IIssuanceService, IssuanceService>();

            services.AddScoped<IReviewService, ReviewService>();

            // Add memory cache services
            services.AddMemoryCache();

            services.AddMvc();

            _services = services;
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseStaticFiles();

            app.UseAuthentication();

            app.UseMvc();
        }
    }
}
