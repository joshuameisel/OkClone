require 'spec_helper'
require 'rails_helper'

describe User do
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:dob) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:email) }
  
  describe "#users" do
    let(:straight_man) do 
      FactoryGirl.create(:user,
        gender: "m",
        likes_f: true,
        dob: Date.new(1990, 2, 2)
      )
    end
    
    let(:straight_woman) do
      FactoryGirl.create(:user,
        gender: "f",  
        likes_m: true,
        dob: Date.new(1988, 12, 28)
      )
    end
    
    let(:cougar) do
      FactoryGirl.create(:user,
        gender: "f",
        likes_m: true,
        dob: Date.new(1960, 12, 28)
      )
    end
    
    let(:gay_man) do  
      FactoryGirl.create(:user,
        gender: "m",
        likes_m: true,
        dob: Date.new(1991, 4, 16)
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
      
      it "does include users with the right attributes" do
        expect(straight_man.users).to include straight_woman
      end
      
      it "doesn't return onesself" do
        expect(gay_man.users).not_to include gay_man
      end
    end
  end
end