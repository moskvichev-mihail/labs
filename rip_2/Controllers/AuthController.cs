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
    public class AuthController : Controller
    {
        BlogContext _context;

        public AuthController(BlogContext context)
        {
            _context = context;
        }

        // POST api/<controller>
        [HttpPost]
        public string Post([FromBody] AuthParams value)
        {
            var user = _context.Users.Where(u => u.Email == value.email && u.Password == value.password).ToArray();
            if (user.Length == 0) return "incorrect auth data";

            var token = GenerateToken();
            return token;
        }

        // PUT api/<controller>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }

        private string GenerateToken()
        {
            byte[] time = BitConverter.GetBytes(DateTime.UtcNow.ToBinary());
            byte[] key = Guid.NewGuid().ToByteArray();
            string token = Convert.ToBase64String(time.Concat(key).ToArray());
            return token;
        }

        private void ProcessToken(string token)
        {
            byte[] data = Convert.FromBase64String(token);
            DateTime when = DateTime.FromBinary(BitConverter.ToInt64(data, 0));
            if (when < DateTime.UtcNow.AddHours(-24))
            {
                // too old
            }
        }
    }
}
