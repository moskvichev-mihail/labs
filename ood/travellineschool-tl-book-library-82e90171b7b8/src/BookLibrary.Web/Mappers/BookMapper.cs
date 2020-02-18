using BookLibrary.Core.DomainModels;
using BookLibrary.Web.Extensions;
using BookLibrary.Web.Models;

namespace BookLibrary.Web.Mappers
{
    public static class BookMapper
    {
        public static BookDto Map(this Book book)
        {
            return new BookDto
            {
                Id = book.Id,
                Name = book.Name,
                //Author = book.Author,
                Description = book.Description,
                ReceiptDate = book.ReceiptDate.ToDateString(),
                //Issued = book.Issued,
                //SmallPictureUri = book.SmallPictureUri
            };
        }
    }
}
