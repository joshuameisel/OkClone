require 'spec_helper'
require 'rails_helper'

describe User do
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:dob) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password)}
  
  
  it "should set a mininimum/maximum age" do
    expect(straight_man.min_age).to eq(18)
    expect(straight_man.max_age).to eq(30)
  end


  let(:straight_man) do 
    FactoryGirl.create(:user,
      gender: "m",
      orientation: "straight",
      dob: Date.new(1990, 2, 2)
    )
  end
  
  it "should set a mininimum/maximum age" do
    expect(straight_man.min_age).to eq(18)
    expect(straight_man.max_age).to eq(30)
  end
  
  describe "#users" do
    let(:straight_woman) do
      FactoryGirl.create(:user,
        gender: "f",  
        orientation: "straight",
        dob: Date.new(1988, 12, 28)
      )
    end
    
    let(:cougar) do
      FactoryGirl.create(:user,
        gender: "f",
        orientation: "straight",
        dob: Date.new(1960, 12, 28)
      )
    end
    
    let(:gay_man) do  
      FactoryGirl.create(:user,
        gender: "m",
        orientation: "gay",
        dob: Date.new(1991, 4, 16)
      )
    end
    
    let(:bisexual_man) do  
      FactoryGirl.create(:user,
        gender: "m",
        orientation: "bisexual",
        dob: Date.new(1989, 4, 16)
      )
    end
    
    context "without defaults" do
      
      it "doesn't include users with an unpreferred gender" do
        expect(gay_man.users).not_to include straight_woman
      end
      
      it "doesn't include users in the wrong age range" do
        expect(straight_man.users).not_to include cougar
      end
      
      it "doesn't include users who aren't attracted to current user" do
         expect(gay_man.users).not_to include straight_man
      end
      
      it "does include correct matches for users with gender preference" do
        expect(straight_man.users).to include straight_woman
      end
      
      it "does include correct matches for users without gender preference" do
        expect(bisexual_man.users).to include straight_woman
        expect(bisexual_man.users).to include gay_man
        expect(gay_man.users).to include bisexual_man
      end
      
      
      it "doesn't return onesself" do
        expect(gay_man.users).not_to include gay_man
      end
    end
    
    context "with" do
      
      it "correctly overwrites defaults" do
        options = 
          {show_me: ["m", "f"], who_like: ["m"], min_age: 18, max_age: 70}
        expect(straight_woman.users(options))
          .to include cougar, gay_man, bisexual_man
      end
    end
  end
end