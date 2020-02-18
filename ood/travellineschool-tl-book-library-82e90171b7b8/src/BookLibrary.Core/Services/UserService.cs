using System.Collections.Generic;
using System.Linq;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Interfaces;
using BookLibrary.Core.Specifications;

namespace BookLibrary.Core.Services
{
    public class UserService : IUserService
    {
        private readonly IRepository<User> _userRepository;


        public UserService(IRepository<User> userRepository)
        {
            _userRepository = userRepository;
        }

        public User GetUser(string email, string password)
        {
            return _userRepository.GetSingleBySpec(new UserSpecification(email, password));
        }

    }
}
