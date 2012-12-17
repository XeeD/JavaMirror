JavaMirror::Application.routes.draw do
  resources :jar_files, except: [:edit, :update] do
    resources :bundled_java_classes, only: [:show], shallow: true
  end

  root to: "homepage#index"
end
