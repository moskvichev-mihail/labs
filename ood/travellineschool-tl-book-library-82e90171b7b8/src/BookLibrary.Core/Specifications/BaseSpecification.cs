using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using BookLibrary.Core.Data;

namespace BookLibrary.Core.Specifications
{
    public abstract class BaseSpecification<T> : ISpecification<T>
    {
        protected BaseSpecification(Expression<Func<T, bool>> criteria = null)
        {
            Criteria = criteria;
        }

        public List<Expression<Func<T, object>>> Includes { get; } = new List<Expression<Func<T, object>>>();
        public Expression<Func<T, bool>> Criteria { get; private set; }
        public Expression<Func<T, object>> SortingCriteria { get; private set; }
        public OrderBy SortingOrder { get; private set; }
        public int Skip { get; private set; }
        public int Take { get; private set; }

        protected virtual void AddInclude(Expression<Func<T, object>> includeExpression)
        {
            Includes.Add(includeExpression);
        }

        protected virtual void SetSortingCriteria(Expression<Func<T, object>> criteria, OrderBy orderBy)
        {
            SortingCriteria = criteria;
            SortingOrder = orderBy;
        }

        protected virtual void SetSelectingCriteria(Expression<Func<T, bool>> criteria)
        {
            Criteria = criteria;
        }

        protected virtual void SetSkipTakeCriteria(int skip, int take)
        {
            Skip = skip;
            Take = take;
        }
    }
}
