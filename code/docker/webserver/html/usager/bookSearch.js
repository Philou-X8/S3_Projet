

/**
 *   New function format
 */

function makeSearch(funct, keyword){
    const div = document.getElementById('title');
    const span = div.firstElementChild;

    span.innerHTML = '<br> <strong>' + 'Loading...' + '</strong> </br>';

    axios.get("http://localhost:8888/api/" + funct + "/" + keyword, {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);
            resetBookTable();                               // clear table
            response.data.forEach(addBookToList);           // get new table
            if(response.data.length >= 1){
                span.innerHTML = '<br> <strong>' + 'Search Complete' + '</strong> </br>';
            } else {
                span.innerHTML = '<br> <strong>' + 'Search Complete: No book found' + '</strong> </br>';
            }


        })
        .catch(function (error) {
            console.log('refreshing');
            span.innerHTML = '<br> <strong>' + 'error with the button: ' + error.toString() + '</strong> </br>'
            keycloak.updateToken(5).then(function () {
                console.log('Token refreshed');
            }).catch(function () {
                console.log('Failed to refresh token');
            })
        });
}

function resetBookTable(){
    var tableBody = document.getElementById("book_body");
    if(tableBody != null) {
        tableBody.remove();
    }

    var table = document.getElementById("book_table");
    table.createTBody().id = "book_body";
}

function addBookToList(book){

    //var row = table.insertRow(1);
    tableBody = document.getElementById("book_body");
    var row = tableBody.insertRow(-1);

    row.insertCell(0).innerHTML = '<input type="radio" name="affichage" onClick="selectBook(); return false;"></input>';
    row.insertCell(1).innerHTML = book.book_label;
    row.insertCell(2).innerHTML = book.author_label;
    row.insertCell(3).innerHTML = book.isbn_label;
    row.insertCell(4).innerHTML = book.sigle_label;
    row.insertCell(5).innerHTML = book.program_label;
    //row.insertCell(5).innerHTML = '<a href="' + book.url + '" target="_blank">COOP</a>';
    //row.insertCell(6).innerHTML = book.language_id;

    //document.getElementById("book_link").setAttribute("href",book.url);
}


function searchFromTitle() {
    var searchKeyword = document.getElementById('title_in');

    makeSearch('listBooksFromTitle', searchKeyword.value);
    return false;
}

function searchFromIsbn() {
    var searchKeyword = document.getElementById('isbn_in');

    makeSearch('listBooksFromISBN', searchKeyword.value);

}
function searchFromSigle() {
    var searchKeyword = document.getElementById('sigle_in');

    makeSearch('listBooksFromSigle', searchKeyword.value);

}

function searchFromProgram() {
    var searchKeyword = document.getElementById('program_in');

    makeSearch('listBooksFromProgram', searchKeyword.value);

}

function searchFromAP() {
    var searchKeyword = document.getElementById('ap_in');

    makeSearch('listBooksFromAP', searchKeyword.value);

}


function searchFromLanguage() {
    var searchKeyword = document.getElementById('language_in');

    makeSearch('listBooksFromLanguage', searchKeyword.value);

}

function searchFromAuthor() {
    var searchKeyword = document.getElementById('author_in');

    makeSearch('listBooksFromAuthor', searchKeyword.value);

}