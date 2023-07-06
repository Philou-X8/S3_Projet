function addBook() {
    let title = document.getElementById('in_title').value;
    let auth = document.getElementById('in_author').value;
    let editor = document.getElementById('in_editor').value;
    let cours = document.getElementById('in_class').value;
    let isbn = document.getElementById('in_isbn').value;
    let url = document.getElementById('in_url').value;
    let langue = document.getElementById('in_language').value;



    let params =cours+'|'+ title+'|'+auth+'|'+editor+'|'+isbn+'|'+url+'|'+langue;

    axios.get("http://localhost:8888/api/addBook/" + params, {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            // Handle the response here
            alert("Book added: " + title + " by " + auth+ " editor : "+editor);
        })
        .catch(function (error) {
            // Handle any errors that occur during the request
            alert("error dans add book");
        });
}

function deleteBook(){
    const bookId = document.getElementById('in_BookID').value;

    axios.get("http://localhost:8888/api/deleteBook/"+bookId,{
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })

        .then(function (response){
            alert(bookId)
        })
        .catch(function (error){
            alert(error.toString())
        })
}