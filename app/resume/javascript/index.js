document.addEventListener('DOMContentLoaded', function () {
  document.getElementById('about-button').addEventListener('click', function () {
    var contentElement = document.getElementById('about');
    contentElement.scrollIntoView({ behavior: 'smooth' });
  });

  document.getElementById('projects-button').addEventListener('click', function () {
    var contentElement = document.getElementById('projects');
    contentElement.scrollIntoView({ behavior: 'smooth' });
  });

  document.getElementById('work-button').addEventListener('click', function () {
    var contentElement = document.getElementById('work');
    contentElement.scrollIntoView({ behavior: 'smooth' });
  });
});
