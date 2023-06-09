
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
            printBookInfo(response.data);
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

    axios.get("http://localhost:8888/api/getBookFromSigle/"+sigleBook.value, {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);
            printBookInfo(response.data);
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
            response.data.forEach(printBookInfo);

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