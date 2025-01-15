require 'rails_helper'

RSpec.describe MindMapController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { user = User.create!(email: "sample@hat.com", password: "sample@123") }
  let(:mind_map1) { mind_map1 = user.mind_maps.create!(title: "sample 1", moto: "sample moto for sample 1") }
  let(:mind_map2) { mind_map2 = user.mind_maps.create!(title: "sample 2", moto: "sample moto for sample 2") }

  before(:all) {
    MindMap.destroy_all
    User.destroy_all
  }

  describe "GET /index" do
    it "assign the mind_map for the particular user" do
      get :index
      user1 = User.create!(email: "sample1@hat.com", password: "sample@123")
      mind_map3 = user1.mind_maps.create!(title: "Other mindmap", moto: "moto for the other mindmap")
      expect(assigns(:mind_maps).to_a).not_to include(mind_map3)
    end

    it "before signin redirected to the users/sign_in" do
      get :index
      expect(response).to redirect_to("/users/sign_in")
    end
  end

  describe "GET new_mind_map" do
    it "assign the mind map" do
      new_map = MindMap.new
      expect(new_map).to be_a_new(MindMap)
    end
  end

  describe "GET steps/:map_id" do
    it "assigns the step belongs to the map_id" do
      step = mind_map1.steps.create!(title: "sample step")
      all = Step.all
      expect(all).to eq([step])
    end

    it "assign the new step" do
      new_step = Step.new
      expect(new_step).to be_a_new(Step)
    end
  end

  describe "GET implementations/:step_id" do
    it "assigns the implementation belongs to the step_id" do
      User.find_by(email: "sample1@hat.com").destroy
      user1 = User.create!(email: "sample1@hat.com", password: "sample@123")
      mind_map = user1.mind_maps.create!(title: "Other mindmap", moto: "moto for the other mindmap")
      step = Step.create!(title: "step", mind_maps_id: mind_map.id)
      implementation = step.implementations.create!(details: "details")
      expect(Implementation.where(details: "details")).to be_present
    end

    it "assign the new implementation" do
      new_implementation = Implementation.new
      expect(new_implementation).to be_a_new(Implementation)
    end
  end

  describe "GET shared" do
    let(:curr_user) { curr_user = User.create(email: "test@hat.com", password: "test@123") }
    let(:share1) { share1 = MindMap.create(title: "mind Map", moto: "test moto fot MM", user_id: curr_user.id, shared_with: ["test@hat.com"] ) }
    let(:share2) { share2 = MindMap.create(title: "test Mind Map", moto: "test moto", user_id: curr_user.id, shared_with: ["test@hat.com"]) }

    # it "assign the shared mind map" do
    #   expect(assigns(:shared_mind_map)).to include(share1, share2)
    # end
  end

  describe "GET share/:id" do
    it "assign the shared mind map" do
      map = MindMap.new
      expect(map).to be_a_new(MindMap)
    end
  end
end
