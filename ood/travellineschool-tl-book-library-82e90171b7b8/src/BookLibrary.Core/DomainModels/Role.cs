using System.Collections.Generic;
using BookLibrary.Core.Data;

namespace BookLibrary.Core.DomainModels
{
	public class Role : BaseEntity
	{
        public Role()
        {
            Users = new List<User>();
        }

        public string Name { get; set; }
        public List<User> Users { get; set; }
    }
}
