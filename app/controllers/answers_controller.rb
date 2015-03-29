class AnswersController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource :question
  load_and_authorize_resource :answer, through: :question

  add_breadcrumb "Home", :root_path


  def edit
    add_breadcrumb "Browse", questions_path
    add_breadcrumb "View Question", question_path(id: params[:question_id])
    add_breadcrumb "Edit Answer"
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      reward_points @answer, :answer
      redirect_to question_path(@question), notice: "Thank you for your answer."
    else
      render 'edit'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    @answer.destroy

    remove_points @answer

    redirect_to question_path(@question)
  end

  def vote

    @vote = AnswerVote.new(answer_id: params[:id], user_id: current_user.id)

    if @vote.save
      reward_points @vote, :vote
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
      remove_points @vote
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
      reward_best_points @question, @answer
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
