document.addEventListener('DOMContentLoaded', () => {
  // Open popup
  document.querySelectorAll('.popup-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const popupId = btn.dataset.popup;
      document.getElementById(popupId).style.display = 'block';
    });
  });

  // Close popup
  document.querySelectorAll('.close').forEach(span => {
    span.addEventListener('click', () => {
      const popupId = span.dataset.popup;
      document.getElementById(popupId).style.display = 'none';
    });
  });

  // Close when clicking outside the popup content
  window.onclick = function(event) {
    if (event.target.classList.contains('popup')) {
      event.target.style.display = 'none';
    }
  };
});
