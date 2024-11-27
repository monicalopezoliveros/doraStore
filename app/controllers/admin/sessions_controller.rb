# app/controllers/admin/sessions_controller.rb
class Admin::SessionsController < Devise::SessionsController
  # Si deseas personalizar el comportamiento de inicio de sesión para los administradores,
  # puedes hacerlo aquí, por ejemplo, agregando lógica después del inicio de sesión.

  # Si no necesitas personalización, puedes dejar este controlador vacío
  # o solo sobrescribir el método `create` para añadir lógica después del inicio de sesión.
end
