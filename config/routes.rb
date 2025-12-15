Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index' # ログイン後の遷移先
  resources :tasks

  # 管理者画面用
  namespace :admin do
    resources :users do
      resources :tasks, only: [:index]
    end
    resources :labels
  end

  get "up" => "rails/health#show", as: :rails_health_check

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # エラーページ用
  get "500", to: "errors#internal_server_error", as: :internal_server_error
  # すべての未定義ルートを404へ
  match "*path", to: "errors#not_found", via: :all
end
