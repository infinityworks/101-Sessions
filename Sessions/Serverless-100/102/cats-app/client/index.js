document.addEventListener('DOMContentLoaded', function onDOMContentLoaded () {
    refreshImage();

    document
        .getElementById('refresh-button')
        .addEventListener('click', refreshImage);
    
    document
        .getElementById('upload-button')
        .addEventListener('click', openFileDialog);

    document
        .getElementById('file-select')
        .addEventListener('change', uploadFile);

    function refreshImage () {
        let holder = document.getElementById('image-holder');
        holder.innerHTML = '';
        let img = document.createElement('img');
        fetch('cats/random')
            .then(res => res.status === 200 ? res.json() : res.text().then(j => Promise.reject(j)))
            .then(data => (img.src = data.image))
            .catch(err => alert(err));
        holder.appendChild(img);
    }

    function openFileDialog () {
        document.getElementById('file-select').click();
    }

    function uploadFile (e) {
        var reader = new FileReader();
        reader.onload = function onload () {
            fetch('cats', {
                method: 'POST',
                body: JSON.stringify({ image: btoa(reader.result)}),
                headers: { 'Content-Type': 'application/json' },
            })
            .then(res => res.status === 200 ? null : res.text().then(j => Promise.reject(j)))
            .catch(err => alert(err));
        };
        reader.readAsBinaryString(e.target.files[0]);
    }
});