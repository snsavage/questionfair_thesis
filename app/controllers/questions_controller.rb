class QuestionsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

  def index
    if Question::CATEGORIES.include?(params[:category])
      @questions = Question.find_by_category(params[:category]).page(params[:page]).order('created_at DESC').per_page(20)
    else
      @questions = Question.page(params[:page]).order('created_at DESC').per_page(20)
    end
  end

  def show
    @question = Question.find(params[:id])
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
