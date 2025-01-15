require 'rails_helper'

RSpec.describe MindMap, type: :model do
  subject{
    user = User.first
    mind_map = MindMap.new(title: "sample", moto: "sample moto", user_id: user.id)
  }

  before(:context) do 
    MindMap.destroy_all
  end

  context "When create a new Mind Map" do
    it "All fields are valid" do
      expect(subject).to be_valid
    end
    
    it "Any one of the field is empty" do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it "Mindmap title is already taken" do
      subject.save
      user = User.first
      mind_map = MindMap.new(title: "sample", user_id: user.id)
      expect(mind_map).not_to be_valid
    end
  end

  context "Associations" do
    it "has_many association with the step" do
      subject.save
      step = subject.steps.new(title: "test step 1")
      expect(subject.steps).to include(step)
    end

    it "belongs to a user" do
      user = User.first
      expect(subject.user).to eq(user)
    end
  end
end
