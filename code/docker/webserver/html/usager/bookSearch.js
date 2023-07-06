
function requestFromAuthor(){
    var auth = document.getElementById('author_in').value;
    alert(auth)
    axios.get("http://localhost:8888/api/listBooksFromAuthor/"+auth,{
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function(response){})
        .catch(function (error){
            alert(error.toString())
        })
}

function requestFromLanguage(){
    var language = document.getElementById('language_in').value;
    axios.get("http://localhost:8888/api/getBookFromLanguage/"+language, {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
}

function printBookInfo(book){
    const span = document.getElementById('title').firstElementChild;
    var urlLink = book.url.toString();
    span.innerHTML = '<br> <strong>' + 'Search complete' + '</strong> </br>' +
        '<br>Titre: ' + book.label + '</br>' +
        '<br>Cours: ' + book.sigle + '</br>' +
        '<br>Auteur: ' + book.author_id + ', Editeur: ' + book.editor_id + '</br>' +
        '<br>ISBN: ' + book.codeisbn + '</br>' +
        //'<br>URL: ' + urlLink.link(book.data.url) + '</br>' +
        '<br>URL: ' + '<a id="book_link" target="_blank">' + urlLink + '</a></br>' +
        '<br>Publication: ' + book.publicationdate +
        ', Langue: ' + book.language_id +
        ', Format: ' + book.format_id + '</br>'
    document.getElementById("book_link").setAttribute("href",urlLink);
}

function requestFromISBN(){
    const div = document.getElementById('title');
    var isbnBook = document.getElementById('isbn_in').value;
    const span = div.firstElementChild;

    axios.get("http://localhost:8888/api/")

}function requestFromTitle(){
    const div = document.getElementById('title');
    var titleBook = document.getElementById('in_title_search').value;
    const span = div.firstElementChild;

    axios.get("http://localhost:8888/api/")
}
function requestFromID() {
    const div = document.getElementById('title');
    var idBook = document.getElementById('book_id_in');
    const span = div.firstElementChild;

    axios.get("http://localhost:8888/api/getBookFromID/"+idBook.value, {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);
            //printBookInfo(response.data);
            resetBookTable();
            addBookToList(response.data);

            //span.innerHTML = '<br> <strong>' + 'button clicked' + '</strong> </br>' +
            //    '<br> <strong>' + response.data.codeisbn + '</strong> </br>'
        })
        .catch(function (error) {
            console.log('refreshing');
            span.innerHTML = '<br> <strong>' + 'error with the button' + '</strong> </br>' +
                '<br> <strong>' + error.toString() + '</strong> </br>'
            keycloak.updateToken(5).then(function () {
                console.log('Token refreshed');
            }).catch(function () {
                console.log('Failed to refresh token');
            })
        });
    span.innerHTML = '<br> <strong>' + "Loading..." + '</strong> </br>'
}

function requestFromSigle() {
    const div = document.getElementById('title');
    var sigleBook = document.getElementById('sigle_in');
    const span = div.firstElementChild;

    span.innerHTML = '<br> <strong>' + 'Loading...' + '</strong> </br>';

    axios.get("http://localhost:8888/api/getBookFromSigle/"+sigleBook.value, {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);
            //printBookInfo(response.data);
            resetBookTable();
            addBookToList(response.data);
            span.innerHTML = '<br> <strong>' + 'Search Complete' + '</strong> </br>';
        })
        .catch(function (error) {
            console.log('refreshing');
            span.innerHTML = '<br><strong>' + 'error with the button: ' + error.toString() + '</strong></br>'
            keycloak.updateToken(5).then(function () {
                console.log('Token refreshed');
            }).catch(function () {
                console.log('Failed to refresh token');
            })
        });

}

function requestAllBook() {
    const div = document.getElementById('title');
    const span = div.firstElementChild;

    axios.get("http://localhost:8888/api/getBookAll", {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);
            resetBookTable();
            response.data.forEach(addBookToList);

        })
        .catch(function (error) {
            console.log('refreshing');
            span.innerHTML = '<br> <strong>' + 'error with the button' + '</strong> </br>' +
                '<br> <strong>' + error.toString() + '</strong> </br>'
            keycloak.updateToken(5).then(function () {
                console.log('Token refreshed');
            }).catch(function () {
                console.log('Failed to refresh token');
            })
        });
    span.innerHTML = '<br> <strong>' + "Loading..." + '</strong> </br>'
}


/**
 *   New function format
 */
function requestFromTitle() {
    const div = document.getElementById('title');
    const span = div.firstElementChild;
    var searchKeyword = document.getElementById('title_in');

    span.innerHTML = '<br> <strong>' + 'Loading...' + '</strong> </br>';

    axios.get("http://localhost:8888/api/listBooksFromTitle/"+searchKeyword, {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);
            resetBookTable();
            response.data.forEach(addBookToList);
            span.innerHTML = '<br> <strong>' + 'Search Complete' + '</strong> </br>';
        })
        .catch(function (error) {
            console.log('refreshing');
            span.innerHTML = '<br> <strong>' + 'error with the button' + '</strong> </br>' +
                '<br> <strong>' + error.toString() + '</strong> </br>'
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


    row.insertCell(0).innerHTML = book.book_label;
    row.insertCell(2).innerHTML = book.author_label;
    row.insertCell(1).innerHTML = book.isbn_label;
    row.insertCell(3).innerHTML = book.sigle_label;
    row.insertCell(4).innerHTML = book.program_label;
    row.insertCell(5).innerHTML = '<a href="' + book.url + '" target="_blank">COOP</a>';
    row.insertCell(6).innerHTML = book.language_id;

    //document.getElementById("book_link").setAttribute("href",book.url);
}