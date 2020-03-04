ActiveAdmin.register User do

  permit_params :email, :disable, :password, :password_confirmation, :first_name, :last_name, :phone

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :first_name
    column :last_name
    column :phone
    column :admin_user_flag
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :phone
      row :admin_user_flag
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :password
      f.input :password_confirmation
      f.input :admin_user_flag
      f.input :phone
    end
    f.actions
  end

end
