using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace BookLibrary.Core.Data
{
    public interface ISpecification<T>
    {
        // Include
        List<Expression<Func<T, object>>> Includes { get; }

        // Where
        Expression<Func<T, bool>> Criteria { get; }

        // OrderBy[Desc]
        Expression<Func<T, object>> SortingCriteria { get; }

        OrderBy SortingOrder { get; }

        // Skip|Take
        int Skip { get; }

        int Take { get; }
    }
}
