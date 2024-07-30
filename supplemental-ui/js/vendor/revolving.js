document.addEventListener('DOMContentLoaded', function() {
    let index = 0;
    const images = document.querySelectorAll('.revolving-image');
    const totalImages = images.length;

    function showNextImage() {
        images[index].classList.remove('visible');
        index = (index + 1) % totalImages;
        images[index].classList.add('visible');
    }

    setInterval(showNextImage, 3000); // Change image every 3 seconds
});
