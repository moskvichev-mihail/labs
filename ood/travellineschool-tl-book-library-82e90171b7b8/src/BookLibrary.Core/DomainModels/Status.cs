using System;
using System.Collections.Generic;
using System.Text;

namespace BookLibrary.Core.DomainModels
{
    public enum BookStatus {
        InStock = 1, // Кнгига в наличии
        SoonFree, // Скоро освободится
        PreOrder, // Предзаказали
        NotAvailable // Нет в наличии
    };
}
