require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user = User.new(email: "testemail@hat.com", password: "Test@123") }

  before(:all) do 
    User.destroy_all
  end

  context "While Register a new User" do
    it "All fields are valid" do
      expect(subject).to be_valid
    end
    
    it "Any one of the field is empty" do
      subject.password = nil
      expect(subject).not_to be_valid
    end

    it "email is already taken" do
      subject.save
      user1 = User.new(email: "testemail@hat.com", password: "Test@321")
      expect(user1).not_to be_valid
    end
  end

  context "When has many mind maps" do
    it "associate with the mind map" do
      subject.save
      mind_map = subject.mind_maps.new(title: "test 1", moto: "test1 moto")
      expect(subject.mind_maps).to include(mind_map)
    end
  end
end
