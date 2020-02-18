using System.Collections.Generic;
using System.Linq;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Interfaces;
using BookLibrary.Core.Specifications;

namespace BookLibrary.Core.Services
{
    public class ReviewService : IReviewService
    {
        private readonly IRepository<Review> _reviewRepository;

        public ReviewService(IRepository<Review> reviewRepository)
        {
            _reviewRepository = reviewRepository;
        }

        public int GetAverageRating(List<Review> reviews)
        {
            int sum = 0;
            int quantity = reviews.Count;
            foreach (var review in reviews)
            {
                sum += review.Rate;
            }
            return quantity == 0 ? 0 : sum / quantity;
        }

        public List<Review> GetBookReviews(int bookId)
        {
            return _reviewRepository.List(new ReviewByBookSpecification(bookId)).ToList();
        }

        public List<Review> GetUserReviews(int userId)
        {
            return _reviewRepository.List(new ReviewByUserSpecification(userId)).ToList();
        }

        public void AddReview(Review review)
        {
            _reviewRepository.Add(review);
        }
    }
}
