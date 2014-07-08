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

  let(:straight_woman) do
    FactoryGirl.create(:user,
      gender: "f",
      orientation: "straight",
      dob: Date.new(1988, 12, 28)
    )
  end

  let(:gay_man) do
    FactoryGirl.create(:user,
      gender: "m",
      orientation: "gay",
      dob: Date.new(1991, 4, 16)
    )
  end

  let(:cougar) do
    FactoryGirl.create(:user,
      gender: "f",
      orientation: "straight",
      dob: Date.new(1960, 12, 28)
    )
  end

  it "should set a mininimum/maximum age" do
    expect(straight_man.min_age).to eq(18)
    expect(straight_man.max_age).to eq(30)
  end

  describe "#users" do

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
        expect(bisexual_man.users).to include(straight_woman, gay_man)
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
        expect(straight_woman.users(options)).to include(
          cougar, gay_man, bisexual_man)
      end
    end
  end

  describe "#conversations" do
    let(:first_message) do
      FactoryGirl.create(:message,
        sender: gay_man, recipient: straight_man, created_at: 3.minutes.ago)
    end

    let(:second_message) do
      FactoryGirl.create(:message,
        sender: straight_man, recipient: gay_man, created_at: 10.minutes.ago)
    end

    let(:third_message) do
      FactoryGirl.create(:message,
        sender: gay_man, recipient: straight_woman, created_at: 10.minutes.ago)
    end

    let(:fourth_message) do
      FactoryGirl.create(:message,
        sender: straight_woman, recipient: gay_man, created_at: 5.minutes.ago)
    end

    let(:fifth_message) do
      FactoryGirl.create(:message,
        sender: straight_man, recipient: straight_woman, created_at: Time.now)
    end

    it "finds the correct users" do
      initiate_messages
      expect(gay_man.conversations.map(&:other_user_id)).to include(
        straight_man.id, straight_woman.id)
    end

    it "doesn't find incorrect users" do
      initiate_messages
      expect(gay_man.conversations.map(&:other_user_id)).not_to include(cougar)
    end

    it "uses the most recent message in a thread" do
      initiate_messages
      expect(gay_man.conversations.map(&:body)).to include(
        first_message.body, fourth_message.body)
    end

    it "orders the threads by most recent message" do
      initiate_messages
      expect(gay_man.conversations.first.other_user_id).to eq(straight_man.id)

      fourth_message.update_attributes(created_at: 2.minutes.ago)
      expect(gay_man.conversations.first.other_user_id).to eq(
        straight_woman.id
      )
    end
  end

  describe "#match_percentage" do
    let(:first_question)  {FactoryGirl.create(:question)}
    let(:second_question) {FactoryGirl.create(:question)}
    let(:third_question)  {FactoryGirl.create(:question)}
    let(:fourth_question) {FactoryGirl.create(:question)}
    let(:fifth_question) {FactoryGirl.create(:question)}

    it "finds the correct users" do
      initiate_questions
      expect(first_question.body).to eq("blah" * 3)
    end
  end
end

def initiate_messages
  first_message && second_message && third_message && fourth_message &&
    fifth_message
end

def initiate_questions
  first_question && second_question && third_question && fourth_question &&
    fifth_question
end