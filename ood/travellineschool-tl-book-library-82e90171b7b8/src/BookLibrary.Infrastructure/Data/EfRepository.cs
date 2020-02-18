using System.Collections.Generic;
using System.Linq;
using BookLibrary.Core.Data;
using Microsoft.EntityFrameworkCore;

namespace BookLibrary.Infrastructure.Data
{
    public class EfRepository<T> : IRepository<T> where T : BaseEntity
    {
        protected readonly BookLibraryContext DbContext;

        public EfRepository(BookLibraryContext dbContext)
        {
            DbContext = dbContext;
        }

        public virtual T GetById(int id)
        {
            return DbContext.Set<T>().Find(id);
        }

        public virtual int GetRecordCount()
        {
            return DbContext.Set<T>().Count();
        }

        public virtual int GetRecordCountBySpec(ISpecification<T> spec)
        {
            var query = spec.Includes
                .Aggregate(DbContext.Set<T>().AsQueryable(),
                    (current, include) => current.Include(include));

            if (spec.Criteria != null)
            {
                query = query.Where(spec.Criteria);
            }

            return query.Count();
        }


        public T GetSingleBySpec(ISpecification<T> spec)
        {
            return List(spec).FirstOrDefault();
        }

        public IEnumerable<T> ListAll()
        {
            return DbContext.Set<T>().AsEnumerable();
        }

        public IEnumerable<T> List(ISpecification<T> spec)
        {
            var query = spec.Includes
                .Aggregate(DbContext.Set<T>().AsQueryable(),
                    (current, include) => current.Include(include));

            if (spec.Criteria != null)
            {
                query = query.Where(spec.Criteria);
            }

            if (spec.SortingCriteria != null)
            {
                query = spec.SortingOrder == OrderBy.Ascending
                    ? query.OrderBy(spec.SortingCriteria)
                    : query.OrderByDescending(spec.SortingCriteria);
            }

            if (spec.Skip != 0)
            {
                query = query.Skip(spec.Skip);
            }

            if (spec.Take != 0)
            {
                query = query.Take(spec.Take);
            }

            return query.AsEnumerable();
        }

        public T Add(T entity)
        {
            DbContext.Set<T>().Add(entity);
            DbContext.SaveChanges();

            return entity;
        }

        public List<T> AddRange(List<T> entities)
        {
            DbContext.Set<T>().AddRange(entities);
            DbContext.SaveChanges();

            return entities;
        }

        public void Update(T entity)
        {
            DbContext.Entry(entity).State = EntityState.Modified;
            DbContext.SaveChanges();
        }

        public void Delete(T entity)
        {
            DbContext.Set<T>().Remove(entity);
            DbContext.SaveChanges();
        }
    }
}
