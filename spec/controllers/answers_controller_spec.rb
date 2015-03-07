require 'rails_helper'

RSpec.describe AnswersController do

  describe 'POST #create' do
    context "without @question" do
      it "does not save the answer" do
      end
    end

    context "with valid attributes" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
        sign_in @user
        @question = create(:question)
        @answer_attributes = attributes_for(:answer, question_id: @question)
      end

      it "saves the new answer to the database" do
        expect{
          post :create, question_id: @question, answer: @answer_attributes
        }.to change(Answer, :count).by(1)
      end

      it "redirects to question#show" do
        post :create, question_id: @question, answer: @answer_attributes
        expect(response).to redirect_to(:action => :show, :id => @question.id)
      end
    end

    context "with invalid attributes" do
      before :each do
        @question = create(:question)
        @answer = build(:invalid_answer, question: @question)
      end

      it "does not save the new answer to the database" do
        expect(@answer).to be_invalid
      end

      it "re-renders question#show" do
        expect(response).to render_template('questions/show')
      end
    end

  end


  
end