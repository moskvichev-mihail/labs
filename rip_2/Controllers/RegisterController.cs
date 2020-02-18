using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using rip.Models;
using rip.Params;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace rip.Controllers
{
    [Route("api/[controller]")]
    public class RegisterController : Controller
    {
        BlogContext _context;

        public RegisterController(BlogContext context)
        {
            _context = context;
        }

        // POST api/<controller>
        [HttpPost]
        public string Post([FromBody] AuthParams value)
        {
            var users = _context.Users.Where(u => u.Email == value.email).ToArray();
           
            if (users.Length != 0) return "user already exist";

            var user = new User
            {
                Email = value.email,
                Password = value.password
            };
            _context.Users.Add(user);
            _context.SaveChanges();
            return "success";
        }
    }
}
