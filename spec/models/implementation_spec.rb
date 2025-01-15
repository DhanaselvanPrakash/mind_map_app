require 'rails_helper'

RSpec.describe Implementation, type: :model do
  let(:user) { user = User.first }
  let(:mind_map) { mind_map = user.mind_maps.new(title: "sample mind map", moto: "sample moto") }
  let(:step) { step = mind_map.steps.new(title: "sample step") }
  let(:implementation) { implementation = step.implementations.new(details: "sample details") }

  before(:context) do 
    MindMap.destroy_all
    Step.destroy_all
    Implementation.destroy_all
  end

  context "When create a new implementation for the step" do
    it "All fields are valid" do
      expect(implementation).to be_valid
    end
    
    it "Title field is empty" do
      implementation.details = nil
      expect(implementation).not_to be_valid
    end

    it "Implementation details is already given" do
      implementation.save
      imple = step.implementations.new(details: "sample details")
      expect(imple).not_to be_valid
    end
  end

  context "Associations" do
    it "belongs to a step" do
      expect(implementation.step).to eq(step)
    end
  end
end
