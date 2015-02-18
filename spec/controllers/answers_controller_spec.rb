require 'rails_helper'

describe AnswersController do

  describe 'POST #create' do
    context "without @question" do
      it "does not save the answer" do
      end
    end

    context "with valid attributes" do
      before :each do
        @question = create(:question)
        @answer = create(:answer, question: @question)
        @answer_attributes = FactoryGirl.attributes_for(:answer, question_id: @question)
      end

      it "saves the new answer to the database" do
        expect{
          post :create, question_id: @question, answer: @answer
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