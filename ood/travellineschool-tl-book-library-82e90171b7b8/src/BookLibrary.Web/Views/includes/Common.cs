using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace BookLibrary.Web.Views.Includes
{
    static public class Common
    {
        public static OrderBy GetAgainstOrderBy(OrderBy orderBy)
        {
            return orderBy == OrderBy.Ascending ? OrderBy.Descending : OrderBy.Ascending;
        }

        public static SelectList ToSelectList<TEnum>(this TEnum enumObj)
            where TEnum : struct, IComparable, IFormattable, IConvertible
        {
            var values = from TEnum e in Enum.GetValues(typeof(TEnum))
                         select new { Id = e, Name = e.ToString() };
            return new SelectList(values, "Id", "Name", enumObj);
        }

        public static string GetGenreName(List<Genre> genres, int genreId)
        {
            if (genreId == 0)
            {
                return "";
            }

            foreach (var genre in genres)
            {
                if (genreId == genre.Id)
                {
                    return genre.Name;
                }
            }

            return "";
        }
    }
}
