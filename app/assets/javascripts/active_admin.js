//= require active_admin/base


document.addEventListener('DOMContentLoaded', function () {
    // Escuchar cambios en el campo de productos
    document.querySelectorAll('[id^="product_"]').forEach(function (productField) {
      productField.addEventListener('change', function () {
        var productId = this.value;
        var priceField = document.getElementById('price_' + this.id.split('_')[1]);

        // Hacer una solicitud para obtener el precio del producto seleccionado
        fetch('/products/' + productId)
          .then(response => response.json())
          .then(data => {
            if (data && data.price) {
              priceField.value = data.price.toFixed(2); // Rellenar el campo de precio con el precio del producto
            }
          })
          .catch(error => console.error('Error:', error));
      });
    });
  });
