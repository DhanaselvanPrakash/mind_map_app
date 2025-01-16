Rails.application.routes.draw do
  devise_for :users
  
  # ROOT ->
  root 'mind_map#index'

  # GET new_mind_map ->
  get 'new_mind_map', to: "mind_map#new_mind_map", as: :new_mind_map
  # POST create_mind_map
  post 'create_mind_map', to: "mind_map#create_mind_map", as: :create_mind_map
  # DELETE destroy_mind_map/:id
  delete 'destroy_mind_map/:id', to: "mind_map#destroy_mind_map", as: :destroy_mind_map

  # GET visualize
  get 'visualize/:id', to: "mind_map#visualize", as: :visualize

  #GET show_visualization
  get 'show_visualization/:id', to: "mind_map#show_visualization", as: :show_visualization

  # GET steps/:map_id ->
  get 'steps/:id', to: "mind_map#steps", as: :steps
  # POST create_step
  post 'create_step', to: "mind_map#create_step", as: :create_step
  # DELETE destroy_step/:id
  delete 'destroy_step/:id', to: "mind_map#destroy_step", as: :destroy_step
  # GET update_step/:id
  get 'update_step/:id', to: "mind_map#update_step", as: :update_step
  # PATCH update/:id
  patch 'update/:id', to: "mind_map#update", as: :update

  # GET implementations/:step_id ->
  get 'implementations/:id', to: "mind_map#implementations", as: :implementations
  # POST create_implementation
  post 'create_implementation', to: "mind_map#create_implementation", as: :create_implementation
  # DELETE destroy_implementation/:id
  delete 'destroy_implementation/:id', to: "mind_map#destroy_implementation", as: :destroy_implementation
  # get update_implementation/:id
  get 'update_implementation/:id', to: "mind_map#update_implementation", as: :update_implementation
  # PATCH update
  patch "update_imple/:id", to: "mind_map#update_imple", as: :update_imple

  # GET shared
  get 'shared_mind_map', to: "mind_map#shared_mind_map", as: :shared_mind_map

  # GET share/:id
  get 'share/:id', to: "mind_map#share", as: :share
  # POST shared_mind_map
  post 'share_mind_map', to: "mind_map#share_mind_map", as: :share_mind_map
end
