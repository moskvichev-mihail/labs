using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary.Core.Data;
using Microsoft.AspNetCore.Http;

namespace BookLibrary.Web.Views.Includes
{
    static public class QueryFunctions
    {
        public static string GetCatalogUri(string searchString, string sort, OrderBy orderBy, int genreId)
        {
            string result = "";

            if (sort != "")
            {
                result += $"sort={sort}&";
            }

            if (searchString != "")
            {
                result += $"searchString={searchString}&";
            }

            if (genreId != 0)
            {
                result += $"genreId={genreId}&";
            }

            result += $"orderBy={orderBy}";

            return result;
        }

        public static string GetAccountUri(string category)
        {
            string result = "";

            if (category != "")
            {
                result += $"category={category}";
            }

            return result;
        }

        public static int GetNextPage(int page)
        {
            return ++page;
        }

        public static int GetPrevPage(int page)
        {
            return --page;
        }
    }
}
