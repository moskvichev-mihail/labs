using System.Collections.Generic;

namespace BookLibrary.Core.Data
{
    public interface IRepository<T> where T : BaseEntity
    {
        T GetById(int id);
        T GetSingleBySpec(ISpecification<T> spec);
        IEnumerable<T> ListAll();
        IEnumerable<T> List(ISpecification<T> spec);
        T Add(T entity);
        List<T> AddRange(List<T> entities);
        void Update(T entity);
        void Delete(T entity);
        int GetRecordCount();
        int GetRecordCountBySpec(ISpecification<T> spec);
    }
}
