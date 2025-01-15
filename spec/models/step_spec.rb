require 'rails_helper'

RSpec.describe Step, type: :model do
  subject {
    mind_map = MindMap.first
    step = mind_map.steps.new(title: "sample step")
  }

  context "When create a new step for the mindmap" do
    it "All fields are valid" do
      expect(subject).to be_valid
    end
    
    it "Title field is empty" do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it "step title is already taken" do
      subject.save
      mind_map = MindMap.first
      step = mind_map.steps.new(title: "sample step")
      expect(step).not_to be_valid
    end
  end

  context "Associations" do
    it "has_many association with the implementations" do
      subject.save
      implementaion = subject.implementations.new(details: "test implementation 1")
      expect(subject.implementations).to include(implementaion)
    end

    it "belongs to a Mind Map" do
      mind_map = MindMap.first
      expect(subject.mind_maps).to eq(mind_map)
    end
  end
end
