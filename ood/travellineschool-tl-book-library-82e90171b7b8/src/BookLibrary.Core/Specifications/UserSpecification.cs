using BookLibrary.Core.DomainModels;

namespace BookLibrary.Core.Specifications
{
    public sealed class UserSpecification : BaseSpecification<User>
    {
        public UserSpecification(string email, string password)
            : base(u => u.Email == email && u.Password == password)
        {
            AddInclude(r => r.Role);
        }
    }
}
