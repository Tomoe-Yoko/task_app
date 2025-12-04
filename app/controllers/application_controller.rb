class ApplicationController < ActionController::Base
  include Pagy::Method # pagenation

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # ← ログイン画面に戻す
  end
end
