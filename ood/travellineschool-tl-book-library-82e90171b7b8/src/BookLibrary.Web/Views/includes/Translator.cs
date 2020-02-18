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
    static public class Translator
    {

        static Dictionary<string, string> s_m_dictionary_book_status = new Dictionary<string, string>
        {
            { "instock", "В наличии" },
            { "preorder", "Предзаказ" },
            { "soonfree", "Скоро будет" },
            { "notavailable", "Нет в наличии" }
        };

        public static string TranslateBookStatus(string translatedWord)
        {
            foreach (var pair in s_m_dictionary_book_status)
            {
                if (pair.Key == translatedWord.ToLower())
                {
                    return pair.Value;
                }
            }
            return "";
        }

        public static SelectList GetTranslatedBookStatusList<TEnum>(this TEnum enumObj)
            where TEnum : struct, IComparable, IFormattable, IConvertible
        {
            var values = from TEnum e in Enum.GetValues(typeof(TEnum))
                         select new { Id = e, Name = TranslateBookStatus(e.ToString()) };
            return new SelectList(values, "Id", "Name", enumObj);
        }

        public static SelectList GetTranslatedBookStatusList(int optionNumber)
        {
            var values = from BookStatus e in Enum.GetValues(typeof(BookStatus))
                         select new { Id = e, Name = TranslateBookStatus(e.ToString()) };
            return new SelectList(values, "Id", "Name", optionNumber);
        }
    }
}
