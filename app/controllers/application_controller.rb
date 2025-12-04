class ApplicationController < ActionController::Base
  include Pagy::Method # pagenation

  before_action :authenticate_user!
  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path # ← ログイン画面に戻す
  end
end
