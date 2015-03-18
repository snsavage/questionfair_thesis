class AnswersController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource :question
  load_and_authorize_resource :answer, through: :question

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      redirect_to question_path(@question)
    else
      @question = Question.find(params[:question_id])
      @answers = @question.answers.includes(:user, :answer_votes)
      render 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    @answer.destroy

    redirect_to question_path(@question)
  end

  def vote

    @vote = AnswerVote.create(answer_id: params[:id], user_id: current_user.id)

    if @vote.save
      redirect_to :back, notice: "Thank you for voting."
    else
      redirect_to :back, notice: "Your vote could not be saved."
    end

  end

  private
    def answer_params
      params.require(:answer).permit(:answer)
    end

end
