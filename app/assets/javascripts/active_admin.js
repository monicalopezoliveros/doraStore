//= require active_admin/base

document.addEventListener('DOMContentLoaded', function () {
  // Escuchar cambios en el campo de productos
  document.querySelectorAll('[id^="product_"]').forEach(function (productField) {
    productField.addEventListener('change', function () {
      var productId = this.value; // ID del producto seleccionado
      var priceField = document.getElementById('price_' + this.id.split('_')[1]); // Campo de precio relacionado

      // Verificar que se haya seleccionado un producto
      if (productId) {
        // Hacer una solicitud para obtener el precio del producto seleccionado
        fetch('/products/' + productId + '.json') // Asegúrate de que esta ruta esté configurada
          .then(response => {
            if (response.ok) {
              return response.json();
            } else {
              throw new Error('No se pudo obtener el precio del producto.');
            }
          })
          .then(data => {
            if (data && data.price) {
              priceField.value = data.price.toFixed(2); // Rellenar el campo de precio
            }
          })
          .catch(error => console.error('Error:', error));
      } else {
        priceField.value = ''; // Vaciar el campo si no hay producto seleccionado
      }
    });
  });
});
