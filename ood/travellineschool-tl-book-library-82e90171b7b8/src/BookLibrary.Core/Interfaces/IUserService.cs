using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Interfaces
{
    public interface IUserService
    {
        User GetUser(string email, string password);
    }
}
