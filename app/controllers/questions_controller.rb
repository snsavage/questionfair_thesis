class QuestionsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show, :search]

  load_and_authorize_resource :question

  def search

    @questions = Question.search_all(params[:search]).page(params[:page]).order('created_at DESC').per_page(20)

  end

  def index

    if Question::category_in_categories?(params[:category])
      @category = params[:category]
      @questions = Question.includes(:user).by_category(@category).page(params[:page]).order('created_at DESC').per_page(20)
    else
      @category = "All"
      @questions = Question.includes(:user).page(params[:page]).order('created_at DESC').per_page(20)
    end

  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.includes(:user, :answer_votes)
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(:question, :category)
    end

end
