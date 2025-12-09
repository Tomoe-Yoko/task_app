Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index' # ログイン後の遷移先
  resources :tasks

  # 管理者画面用
  namespace :admin do
    resources :users do
      resources :tasks, only: [:index]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
