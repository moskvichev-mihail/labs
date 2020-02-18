using System.Collections.Generic;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Dto;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace BookLibrary.Web.ViewModels
{
    public class DetailPageViewModel
    {
        public BookInfo BookInfo { get; set; }
        public List<BookInfo> SimilarBooksInfos { get; set; }
        public List<Review> Reviews { get; set; }
        public int Rating { get; set; }
        public SelectList Genres { get; set; }
        public SelectList Libraries { get; set; }
        public string Role { get; set; }
    }
}
