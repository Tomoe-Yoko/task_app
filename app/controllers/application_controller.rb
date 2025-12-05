class ApplicationController < ActionController::Base
  include Pagy::Method # pagenation

  before_action :authenticate_user!
  before_action :username_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path # ← ログイン画面に戻す
  end

  protected # 継承したクラスからは呼べるようにする

  def username_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
