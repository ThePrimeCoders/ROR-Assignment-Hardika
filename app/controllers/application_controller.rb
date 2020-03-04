class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def authenticate_admin_user!
		authenticate_user!
		unless current_user.admin_user_flag?
		  redirect_to root_path, flash: { alert: I18n.t('message.admin.redirect_permission') }
		end
	end

	def after_sign_in_path_for(resource)
		admin_root_path
	end
	def after_sign_out_path_for(resource)
		root_path
	end
end
