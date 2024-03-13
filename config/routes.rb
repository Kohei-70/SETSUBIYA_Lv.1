Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    resources :users, only: [:show, :edit, :update]
    resources :quizzes, only: [:index, :show]
    resources :bookmarks, only: [:index, :show]
    resources :searches, only: [:index, :show]
    root to: 'homes#top'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :quizzes, only: [:index, :new, :create, :show, :edit, :update]
  end

end
