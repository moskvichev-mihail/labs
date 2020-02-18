using System.Collections.Generic;
using BookLibrary.Core.DomainModels;

namespace BookLibrary.Web.ViewModels
{
    public class AccountHistoryViewModel
    {
        public List<Issuance> Issuances { get; set; }
        public int Page { get; set; }
        public int MaxPage { get; set; }
    }
}
