AngularTryout::Application.routes.draw do
  get 'jme_forum' => 'jme_forum#index'

  root to: 'todos#index'
end
