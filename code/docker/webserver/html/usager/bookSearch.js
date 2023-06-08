

function printBookInfo(book){
    const span = document.getElementById('title').firstElementChild;
    var urlLink = book.data.url.toString();
    span.innerHTML = '<br> <strong>' + 'Search complete' + '</strong> </br>' +
        '<br>Titre: ' + book.data.label + '</br>' +
        '<br>Cours: ' + book.data.sigle + '</br>' +
        '<br>Auteur: ' + book.data.author_id + ', Editeur: ' + book.data.editor_id + '</br>' +
        '<br>ISBN: ' + book.data.codeisbn + '</br>' +
        //'<br>URL: ' + urlLink.link(book.data.url) + '</br>' +
        '<br>URL: ' + '<a id="book_link" target="_blank">' + urlLink + '</a></br>' +
        '<br>Publication: ' + book.data.publicationdate +
        ', Langue: ' + book.data.language_id +
        ', Format: ' + book.data.format_id + '</br>'
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
            printBookInfo(response);
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
            printBookInfo(response);
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