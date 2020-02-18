using System;
using System.Collections.Generic;
using System.Linq;
using BookLibrary.Core.Data;
using BookLibrary.Core.DomainModels;
using BookLibrary.Core.Interfaces;
using BookLibrary.Core.Models;
using BookLibrary.Core.Specifications;

namespace BookLibrary.Core.Services
{
    public class IssuanceService : IIssuanceService
    {
        private readonly IRepository<Issuance> _issuanceRepository;

        public IssuanceService(IRepository<Issuance> issuanceRepository)
        {
            _issuanceRepository = issuanceRepository;
        }

        public void AddIssuance(int bookItemId, int userId)
        {
            Issuance issuance = new Issuance
            {
                UserId = userId,
                BookItemId = bookItemId
            };

            _issuanceRepository.Add(issuance);
        }

        public void UpdateIssuance(Issuance issuance)
        {
            _issuanceRepository.Update(issuance);
        }

        public List<Issuance> GetMyBooks(int userId)
        {
            return _issuanceRepository.List(new UserBooksSpecification(userId)).ToList();
        }

        public List<Issuance> GetHistory(SearchAccountPattern searchAccountPattern)
        {
            return _issuanceRepository.List(new UserHistorySpecification(searchAccountPattern)).ToList();
        }

        public int GetIssuanceQuantity(int userId)
        {
            return _issuanceRepository.GetRecordCountBySpec(new IssuancesCountSpecification(userId));
        }
    }
}
