function addBook() {
    let title = document.getElementById('in_title').value;
    let auth = document.getElementById('in_author').value;

    axios.get("http://localhost:8888/api/addBook", {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            // Handle the response here
            alert("Book added: " + title + " by " + auth);
        })
        .catch(function (error) {
            // Handle any errors that occur during the request
            console.error(error);
        });
}