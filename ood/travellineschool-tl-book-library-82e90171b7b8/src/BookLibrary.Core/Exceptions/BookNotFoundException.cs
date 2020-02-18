using System;

namespace BookLibrary.Core.Exceptions
{
    public class BookNotFoundException : Exception
    {
        public BookNotFoundException(int bookId) : base($"No book found with id {bookId}")
        {
        }

        protected BookNotFoundException(System.Runtime.Serialization.SerializationInfo info,
            System.Runtime.Serialization.StreamingContext context) : base(info, context)
        {
        }

        public BookNotFoundException(string message) : base(message)
        {
        }

        public BookNotFoundException(string message, Exception innerException) : base(message, innerException)
        {
        }
    }
}
