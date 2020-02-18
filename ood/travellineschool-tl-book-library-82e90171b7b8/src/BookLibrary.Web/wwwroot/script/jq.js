$(document).ready(function () {
    addSearchHandler(searchForm, dropdownInput);
    addArrowsToButtons(receiptDateButton, popularityButton);
    alertAboutAddingBookInformation();
    addingBookToUser();
    returnBook();
    login();
    locateLoginWindow(loginWindow);
    addStars();
    changeStars();
    burgerMenu();
    QuantityStatusChanging();
});

searchForm = $("#jq__search__form");
dropdownInput = $("#jq__dropdawn");

receiptDateButton = $("#jq__receipt__date");
popularityButton = $("#jq__popularity");

loginWindow = $("#jq__login__window");

function locateLoginWindow(loginWindow) {
    marginTop = (($(window).height() - loginWindow.innerHeight()) / 2) + "px";
    loginWindow.css("margin", marginTop + " auto");
    $(window).resize(function () {
        marginTop = (($(window).height() - loginWindow.innerHeight()) / 2) + "px";
        loginWindow.css("margin", marginTop + " auto");
    });
}

function tryToAddArow(button, buttonName) {
    orderBy = getSearchParams("orderBy");
    currentSort = getSearchParams("sort");
    if (currentSort == undefined) {
        currentSort = "receiptDate";
    }
    if (currentSort == buttonName) {
        if (orderBy == "Descending") {
            button.addClass("sort__arrow__down");
        }
        else {
            button.addClass("sort__arrow__up");
        }
    }
}

function returnBook() {
    returnButton = $(".jq__return__button");
    returnButton.click(function (e) {
        result = confirm("Вы хотите вернуть эту книгу?");
        if (result) {
            alert("Книга удалена с списка ваших книг");
        } else {
            e.preventDefault();
        }
    });
}

function addingBookToUser() {
    bookingButton = $("#jq__booking__button");
    bookingButton.click(function () {
        result = confirm("Вы хотите взять эту книгу?");
        if (result) {
            form = $("#jq__booking__form");
            request = $.ajax({
                type: form.attr("method"),
                url: form.attr("action"),
                data: form.serialize(),
            });

            request.done(function (data) {
                alert(data["statusDescription"]);
            });

            request.fail(function () {
                alert("Не удалось отправить запрос");
            });
        }
    });
}

function login() {
    joinButton = $("#jq__join__login__button");
    joinButton.click(function (e) {
        isEmptyInput = false;
        $(".jq__login__item").each(function () {
            if ($(this).val() == "") {
                isEmptyInput = true;
                return false;
            }
        });
        if (isEmptyInput) {
            alert('Не все поля заполнены');
        } else {
            form = $("#jq__login__form");
            request = $.ajax({
                type: form.attr('method'),
                url: form.attr('action'),
                data: form.serialize(),
            });

            request.done(function (data) {
                if (data["statusCode"] == 400) {
                    alert(data["statusDescription"]);
                }
                else {
                    window.location = "/";
                }
            });

            request.fail(function () {
                alert("Не удалось отправить запрос");
            });
        }
        e.preventDefault();
    });
}

function alertAboutAddingBookInformation() {
    submitBookInput = $("#jq__book__submit");
    submitBookInput.click(function () {
        isEmptyInput = false;
        $(".book__property__input").each(function () {
            if ($(this).val() == "") {
                isEmptyInput = true;
                return false;
            }
        });
        if (isEmptyInput) {
            alert('Не все поля заполнены');
        } else {
            $("#jq__management__form").submit();
            alert('Книга успешно добавлена в библиотеку');
        }
    });
}

function addArrowsToButtons(receiptDateButton, popularityButton) {
    tryToAddArow(receiptDateButton, "receiptDate");
    tryToAddArow(popularityButton, "popularity");
}

function addSearchHandler(searchForm, dropdownInput) {
    const BOOKS_URL = '/api/books';
    const SEARCH_RESULT_PAGE = '/catalog';

    itemsWrapper = $('#jq__dropdown__items__wrapper');

    dropdownInput.on('input', function () {
        itemsWrapper.innerHeight(itemsWrapper.innerHeight());
        itemsWrapper.empty();
        newText = $(this).val();
        if (newText.length > 2) {
            $.post(BOOKS_URL, { searchString: newText }, function (data) { addDropdawnItems(data, itemsWrapper) }, 'json');
            itemsWrapper.innerWidth(dropdownInput.innerWidth());
        }
        setTimeout(function () {
            itemsWrapper.innerHeight('auto');
        }, 20);
    });
    dropdownInput.blur(function () {
        setTimeout(function () {
            itemsWrapper.empty();
            itemsWrapper.innerWidth('auto');
        }, 250);
    })
    /*
    dropdownInput.blur(function () {
        setTimeout(function () {
            itemsWrapper.empty();
            itemsWrapper.innerWidth('auto');
        }, 300)
    })
    */

    searchForm.submit(function () {
        itemsWrapper.empty();
        document.location.href = SEARCH_RESULT_PAGE + '?searchString=' + dropdownInput.val();
        return false;
    });
}

function addDropdawnItems(data, itemsWrapper) {
    i = 0;
    $.each(data, function (key, value) {
        bookItem = getSearhItem(value);
        itemsWrapper.append(bookItem);
        ++i;
        if (i == 6) {
            return false;
        }
    });
}

function getSearhItem(value) {
    bookText = '<div class="book__text__search">' + value.name + ' ' + value.author + '</div>';
    searchItem = '<a class="book__link jq__book__link" href="/book?bookId=' + value.id + '">' + bookText + '</a>';
    return searchItem;
}


function getSearchParams(k) {
    var p = {};
    location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (s, k, v) { p[k] = v })
    return k ? p[k] : p;
}

function addStarToSingle(wrapper) {
    starQuantity = wrapper.attr("data-rating");
    i = 0;
    wrapper.children().each(function () {
        if (i == starQuantity) {
            return false;
        }
        $(this).addClass("checked");
        ++i;
    })
}

function addStars() {
    $(".jq__book__rating").each(function () {
        addStarToSingle($(this));
    })

}

function changeStars() {
    $(".new__review__star").click(function () {
        reviewWrapper = $("#jq__review__wrapper");
        reviewWrapper.attr("data-rating", "" + ($(this).index() + 1));
        $('#ratings-hidden').val(($(this).index() + 1));
        reviewWrapper.children().each(function () {
            $(this).removeClass("checked");
        });
        addStarToSingle($(reviewWrapper));
    });
}

function burgerMenu() {
    var BREAKPOINT = 767;

    var navButton = $("#nav_icon");
    var navList = $(".show_nav_list");
    navButton.click(function () {
        navButton.toggleClass("open");
        if (navButton.hasClass("open")) {
            navList.fadeIn();
        }
        else {
            navList.fadeOut();
        }
    });

    var winWidth = $(window).width();
    if (winWidth > BREAKPOINT) {
        navButton.css("display", "none");
        navList.css("display", "block");
    }
    else {
        navList.css("display", "none");
        navButton.css("display", "block");
    }

    $(window).resize(function () {
        setTimeout(function () {
            var winWidth = $(window).width();
            if (winWidth > BREAKPOINT) {
                navButton.css("display", "none");
                navList.css("display", "block");
            }
            else {
                navButton.css("display", "block");
            }
            if (navButton.hasClass("open")) {
                if (winWidth > BREAKPOINT) {
                    navButton.removeClass("open");
                }
            }
            else if (winWidth < BREAKPOINT + 1) {
                navList.css("display", "none");
            }
        }, 100);
    });
}

function QuantityStatusChanging() {
    bookStatus = $("#jq_status");
    bookQuantityInput = $("#jq_quantity");
    bookStatus.change(function () {
        if (bookStatus.val() == "InStock") {
            bookQuantityInput.val(1);
        }
        else {
            bookQuantityInput.val(0);
        }
    });
    bookQuantityInput.change(function () {
        if (bookQuantityInput.val() != 0) {
            bookStatus.val("InStock");
        }
        else {
            bookStatus.val("NotAvailable");
        }
    })
}
