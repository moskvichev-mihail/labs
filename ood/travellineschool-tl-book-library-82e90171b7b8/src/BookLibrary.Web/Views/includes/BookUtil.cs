using System.Collections.Generic;
using System.Linq;
using System.Text;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Web.Views.Includes
{
    public static class BookUtil
    {
        public static string GetString(List<Author> authors)
        {
            List<string> names = authors.Select(a => a.Name).ToList();

            return GetString(names);
        }

        public static string GetString(List<Genre> genres)
        {
            List<string> names = genres.Select(a => a.Name).ToList();

            return GetString(names);
        }

        private static string GetString(List<string> strings)
        {
            var stringBuilder = new StringBuilder();

            foreach (string str in strings)
            {
                stringBuilder.Append($"{str.Trim()}, ");
            }

            if (strings.Count > 0)
            {
                stringBuilder.Remove(stringBuilder.Length - 2, 2);
            }

            return stringBuilder.ToString();
        }
    }
}
