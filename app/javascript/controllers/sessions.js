document.addEventListener('DOMContentLoaded', function() {
  // Password toggle visibility
  const passwordField = document.querySelector('input[type="password"]');
  const togglePasswordBtn = document.querySelector('.toggle-password');
  
  togglePasswordBtn.addEventListener('click', function() {
    const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordField.setAttribute('type', type);
    this.querySelector('i').classList.toggle('bi-eye-fill');
    this.querySelector('i').classList.toggle('bi-eye-slash-fill');
  });
});