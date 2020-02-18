using System.Collections.Generic;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Interfaces
{
    public interface IReviewService
    {
        void AddReview(Review review);
        List<Review> GetBookReviews(int bookId);
        List<Review> GetUserReviews(int userId);
        int GetAverageRating(List<Review> reviews);
    }
}
