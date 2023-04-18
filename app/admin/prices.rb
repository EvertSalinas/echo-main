ActiveAdmin.register Price do
  searchable_select_options(scope:
    lambda do |params|
      binding.pry
      if params[:role] == 'ventas'
        AdminUser.vendedores
      else
        AdminUser.all
      end
    end, text_attribute: :email)

end
