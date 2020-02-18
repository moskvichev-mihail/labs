using System;
using System.Collections.Generic;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Models;

namespace BookLibrary.Core.Interfaces
{
    public interface IIssuanceService
    {
        List<Issuance> GetMyBooks(int userId);
        List<Issuance> GetHistory(SearchAccountPattern searchBooksPattern);
        int GetIssuanceQuantity(int userId);
        void AddIssuance(int bookItemId, int userId);
        void UpdateIssuance(Issuance issuance);
    }
}
