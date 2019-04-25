ActiveAdmin.register Restaurant do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  filter :owner

  permit_params :name, :city, :address, :price, :tags, :delivery_time, :delivery_fee, :owner_id, :image

  form do |f|
    f.inputs do
      f.input :owner
      f.input :name
      f.input :city
      f.input :address
      f.input :price
      f.input :tags
      f.input :delivery_time
      f.input :delivery_fee
      f.input :image, as: :file
    end
    f.actions
  end


end
