class AnswersController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      redirect_to question_path(@question)
    else
      render 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    @answer.destroy

    redirect_to question_path(@question)
  end

  private
    def answer_params
      params.require(:answer).permit(:answer)
    end

end
