class MindMapController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    user_id = current_user.id
    @mind_maps = MindMap.where(user_id: user_id)
  end

  def new_mind_map
    @user_id = current_user.id
    @mind_map = MindMap.new()
  end

  def create_mind_map
    @mind_map = MindMap.new(title: params[:title], moto: params[:moto], user_id: params[:user_id])
    respond_to do |format|
      if @mind_map.save
        format.js
        format.html { redirect_to root_path }
      else
        format.js
        format.html { redirect_to root_path }
      end
    end
  end

  def destroy_mind_map
    @mind_map = MindMap.find(params[:id])
    respond_to do |format|
      if @mind_map.destroy
        format.js
        format.html { redirect_to root_path }
      end
    end
  end

  def steps
    @steps = Step.where(mind_map_id: params[:id])
    @edit = params[:edit]
  end

  def implementations
    @step_id = params[:id]
    @implementations = Implementation.where(step_id: @step_id)
    @edit = params[:edit]
  end

  def shared_mind_map
    user_id = current_user.id
    @user_email = User.find(user_id).email
    @mind_maps = MindMap.all
    @shared_mind_map = Array.new
    @mind_maps.each do |map|
      puts "Shared With -> #{map.shared_with}"
      if map.shared_with.include?(@user_email)
        puts "Works"
        @shared_mind_map << map
      end
    end
  end

  def share
    @mind_map = MindMap.new
    @users_email = User.only('email').map {|user| user.email}
    @id = params[:id]
  end

  def share_mind_map
    @mind_map = MindMap.find(params[:id])
    if !@mind_map.shared_with.include?(params[:user_email])
      puts "works"
      @mind_map.shared_with << params[:user_email]
      @mind_map.save
      redirect_to root_path
    end
  end
end
