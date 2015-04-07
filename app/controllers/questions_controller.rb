class QuestionsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show, :search, :geo_search]

  load_and_authorize_resource :question

  add_breadcrumb "Home", :root_path

  # Location lookup for location search.  Responses with JSON format.
  def geo_search

    @locations = Question.select(:city_state).where("city_state ILIKE ?", "%#{params[:term]}%").group(:city_state)
    respond_to do |format|
      format.json { render json: @locations.map(&:city_state) }
      format.html { redirect_to root_path }
    end

  end

  # Questions Index Action.
  def index

    add_breadcrumb "Browse", :questions_path

    # Checks for location query and then pulls latitude and longitude
    # information is location is found in the database.  
    # This technique is used instead of a proper caching system. 
    if params[:location].present?
      @location = Question.get_stored_location(params[:location])
      @location = @location.nil? ? params[:location] : [@location.latitude, @location.longitude]
    else
      @location = params[:location]
    end

    # Sets the default distance to 10 miles if no distance is present.
    if !params[:distance].present?
      @distance = 10
    elsif Question.distances.map { |distance| distance[0] == params[:distance].to_i }
      @distance = params[:distance].to_i
    else
      @distance = 10
    end

    # Search query.  First checks is category is available.  
    if Question.category_in_categories?(params[:category])
      @category = params[:category]
      @questions = Question.includes(:user).by_location(@location, @distance).by_category(@category).full_text(params[:search]).page(params[:page]).order('created_at DESC').per_page(20)
    else
      @category = "All"
      @questions = Question.includes(:user).by_location(@location, @distance).by_category(@category).full_text(params[:search]).page(params[:page]).order('created_at DESC').per_page(20)
    end

  end

  # Questions show.  
  def show
    add_breadcrumb "Browse", :questions_path
    add_breadcrumb "View Question", :question_path

    @question = Question.find(params[:id])
    @answers = @question.answers.includes(:user, :answer_votes).order(best: :desc).order(created_at: :desc)
    @answer = @question.answers.build
  end

  # Ask a question.
  def new
    add_breadcrumb "Ask Question"
    @question = Question.new
  end

  # Edit a question.
  def edit
    @question = Question.find(params[:id])
    add_breadcrumb "Browse", :questions_path
    add_breadcrumb "View Quesiton", question_path(@question)
    add_breadcrumb "Edit Question"
  end

  # Save a question. 
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      @question.create_activity :create, owner: current_user
      reward_points @question, :ask
      redirect_to @question
    else
      render 'new'
    end
  end

  # Update a question. 
  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  # Delete a question.  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    remove_points @question

    redirect_to questions_path
  end

  private

    # Whitelisted question parameters. 
    def question_params
      params.require(:question).permit(:question, :category, :address)
    end

end
