class AnswersController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource :question
  load_and_authorize_resource :answer, through: :question

  def edit
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      redirect_to question_path(@question)
    else
      render 'edit'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    @answer.destroy

    redirect_to question_path(@question)
  end

  def vote

    @vote = AnswerVote.new(answer_id: params[:id], user_id: current_user.id)

    if @vote.save
      redirect_to :back, notice: "Thank you for voting."
    else
      redirect_to :back, notice: "Your vote could not be saved."
    end

  end

  def unvote
    @vote = AnswerVote.where(answer_id: params[:id], user_id: current_user.id)
    @question = Question.find(params[:question_id])

    if @vote.length == 1
      @vote[0].destroy
    else
      logger.error "Can't delete more than one vote at a time.  AnswersController: Unvote"
      redirect_to :back, notice: "Your vote could not be removed."
    end

    redirect_to :back, notice: "You vote has been removed.  If you wish, please vote again or provide an answer."
  end

  def best
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.best = true
    if @answer.save
      redirect_to :back, notice: "Thank you for selecting a best answer."
    else
      redirect_to :back, notice: "Your selection could not be saved."
    end

  end

  private
    def answer_params
      params.require(:answer).permit(:answer)
    end

end
