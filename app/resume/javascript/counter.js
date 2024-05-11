const url = 'http://api.api.svc.cluster.local:8282/counter/update_count';

const resultElement = document.getElementById('counter');

function makePostRequest() {
    fetch(url, {
        method: 'POST',
        headers: { 
            'Content-Type': 'application/json'
        },
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            resultElement.innerHTML = JSON.stringify(data.message.visitor_count);
        })
        .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
        });
}

window.addEventListener('load', makePostRequest);