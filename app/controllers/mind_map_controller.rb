class MindMapController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_mind_map
  before_action :set_step
  before_action :set_implementation

  def index
    user_id = current_user.id
    @mind_maps = MindMap.where(user_id: user_id)
  end

  def new_mind_map
    @user_id = current_user.id
  end

  def create_mind_map
    @mind_map = MindMap.new(title: params[:title], moto: params[:moto], user_id: params[:user_id])
    respond_to do |format|
      if @mind_map.save
        format.js
        format.html { redirect_to root_path, notice: "Mind Map Created Successfully" }
      else
        format.js
        format.html { redirect_to create_mind_map_path, notice: "All Fields are Required" }
      end
    end
  end

  def visualize
    begin
      @mind_map = MindMap.includes(steps: :implementations).find(params[:id])
      render json: {
        name: @mind_map.title,
        description: @mind_map.moto,
        children: @mind_map.steps.map do |step|
          {
            name: step.title,
            children: step.implementations.map do |impl|
              { name: impl.details }
            end
          }
        end
        }
    rescue => err
      puts err
      redirect_to root_path
    end
  end

  def show_visualization
    @mind_map = MindMap.find(params[:id])
  end

  def destroy_mind_map
    begin
      @mind_map = MindMap.find(params[:id])
      respond_to do |format|
        if @mind_map.destroy
          format.js
          format.html { redirect_to root_path }
        end
      end
    rescue => err
      puts err
    end
  end

  def steps
    @step_id = params[:id]
    @steps = Step.where(mind_maps_id: params[:id])
    @error = params[:error]
  end

  def create_step
    @step = Step.new(title: params[:title], mind_maps_id: params[:map_id])
    respond_to do |format|
      if @step.save
        format.js
        format.html { redirect_to steps_path(params[:map_id]), notice: "Step Added Successfully" }
      else
        format.js
        format.html { redirect_to steps_path(params[:map_id], error: true), notice: "Title is require to add" }
      end
    end
  end

  def update_step
    @step = Step.find_by(id: params[:id])
    @id = params[:id]
    @map_id = params[:map_id]
  end

  def update
    begin
      @id = params[:id]
      @step = Step.find(params[:id])
      if @step.update({title: params[:title]})
        redirect_to steps_path(id: params[:map_id]), notice: "Update sucessfully"
      else  
        redirect_to update_path(@id), notice: "Enable to Update"
      end
    rescue => err
      redirect_to update_path(@id), notice: err
    end
  end

  def destroy_step
    begin
      @step = Step.find(params[:id])
      respond_to do |format|
        if @step.destroy
          format.js
          format.html { redirect_to steps_path(params[:map_id]), notice: "Step deleted successfully" }
        end
      end
    rescue => err
      err
    end
  end

  def implementations
    @step_id = params[:id]
    @implementations = Implementation.where(step_id: @step_id)
    @map_id = params[:map_id]
    @error = params[:error]
  end

  def create_implementation
    @implementaion = Implementation.new(details: params[:details], step_id: params[:step_id])
    respond_to do |format|
      if @implementaion.save
        format.js
        format.html { redirect_to implementations_path(id: params[:step_id], map_id: params[:map_id]), notice: "Implementaion Added Successfully" }
      else
        format.js
        format.html { redirect_to implementations_path(id: params[:step_id], map_id: params[:map_id], error: true), notice: "Details is require to add" }
      end
    end
  end

  def destroy_implementation
    begin
      @implementation = Implementation.find(params[:id])
      respond_to do |format|
        if @implementation.destroy
          format.js
          format.html { redirect_to implementations_path(id: params[:step_id], map_id: params[:map_id]), notice: "Implementaion deleted successfully" }
        end
      end
    rescue => err
      err
    end
  end

  def update_implementation
    @implementation = Implementation.find_by(id: params[:id])
    @id = params[:id]
    @step_id = params[:step_id]
    @map_id = params[:map_id]
  end

  def update_imple
    begin
      @id = params[:id]
      @implementation = Implementation.find(params[:id])
      if @implementation.update({details: params[:implementation][:details]})
        redirect_to implementations_path(id: params[:implementation][:step_id], map_id: params[:implementation][:map_id]), notice: "Update sucessfully"
      else  
        redirect_to update_implementation(@id), notice: "Enable to Update"
      end
    rescue => err
      redirect_to update_implementation(@id), notice: err
    end
  end

  def shared_mind_map
    user_id = current_user.id
    @user_email = User.find(user_id).email
    @mind_maps = MindMap.all
    @shared_mind_map = Array.new
    @mind_maps.each do |map|
      if map.shared_with.include?(@user_email)
        @shared_mind_map << map
      end
    end
  end

  def share
    @users_email = User.only('email').map { |user| user.email }
    @id = params[:id]
  end

  def share_mind_map
    @mind_map = MindMap.find(params[:id])
    if !@mind_map.shared_with.include?(params[:user_email])
      @mind_map.shared_with << params[:user_email]
      @mind_map.save
      redirect_to root_path
    end
  end

  def set_mind_map
    @mind_map = MindMap.new
  end

  def set_step
    @step = Step.new
  end

  def set_implementation
    @implementation = Implementation.new
  end
end
