class QuestionsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show, :search, :geo_search]

  load_and_authorize_resource :question

  add_breadcrumb "Home", :root_path

  def search

    add_breadcrumb "Search", :search_questions_path

    @questions = Question.search_all(params[:search]).page(params[:page]).order('created_at DESC').per_page(20)

  end

  def geo_search

    @locations = Question.select(:city_state).where("city_state ILIKE ?", "%#{params[:term]}%").group(:city_state)
    respond_to do |format|
      format.json { render json: @locations.map(&:city_state) }
      format.html { redirect_to root_path }
    end

  end

  def index

    add_breadcrumb "Browse", :questions_path

    if params[:location].present?
      @location = Question.get_stored_location(params[:location])
      @location = @location.nil? ? params[:location] : [@location.latitude, @location.longitude]
    else
      @location = params[:location]
    end

    if !params[:distance].present?
      @distance = 10
    elsif Question.distances.map { |distance| distance[0] == params[:distance].to_i }
      @distance = params[:distance].to_i
    else
      @distance = 10
    end

    if Question.category_in_categories?(params[:category])
      @category = params[:category]
      @questions = Question.includes(:user).by_location(@location, @distance).by_category(@category).page(params[:page]).order('created_at DESC').per_page(20)
    else
      @category = "All"
      @questions = Question.includes(:user).by_location(@location, @distance).page(params[:page]).order('created_at DESC').per_page(20)
    end

  end

  def show

    add_breadcrumb "View Question", :question_path

    @question = Question.find(params[:id])
    @answers = @question.answers.includes(:user, :answer_votes).order(best: :desc).order(answer_votes_count: :desc).order(:created_at)
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
      params.require(:question).permit(:question, :category, :address)
    end

end
