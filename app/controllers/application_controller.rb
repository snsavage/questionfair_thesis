class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Additional whitelisted parameters for Devise.
  before_action :configure_permitted_parameters, if: :devise_controller?

  check_authorization :unless => :devise_controller?  

  protected

    # Additional whitelisted parameters for Devise.
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << 
        [:nickname, :time_zone, :mail_chimp, :terms]
      devise_parameter_sanitizer.for(:account_update) << 
        [:time_zone, :mail_chimp]
      devise_parameter_sanitizer.for(:accept_invitation).concat 
        [:nickname, :time_zone, :mail_chimp, :terms]
    end

    # Sets User Time Zone
    def set_time_zone
      if user_signed_in?
        Time.use_zone(current_user.time_zone) { yield }
      else
        yield
      end
    end

    # Rewards Points Based on a Model, Action and Point Type
    def reward_points(rewardable, action = params[:action], type)
      points = Point.values[type]
      current_user.points.create rewardable: rewardable, 
        action: action, description: type, points: points 
      flash[:points] = "You just earned #{points} points."
    end

    # Removes Points
    def remove_points(rewardable)
      point = current_user.points.where(rewardable_id: rewardable.id, 
        rewardable_type: rewardable.class.name).first
      point.destroy
    end

    # Rewards Points to Best Answer including points for the provider
    # of the question, answer and any votes. 
    def reward_best_points(question, answer, action = params[:action])
      question_points = Point.values[:best_question]
      answer_points = Point.values[:best_answer]
      vote_points = Point.values[:best_vote]

      Point.create(user_id: question.user_id,
                   action: action,
                   rewardable_id: question.id,
                   rewardable_type: question.class.name,
                   description: :best_question,
                   points: question_points)

      Point.create(user_id: answer.user_id,
                   action: action,
                   rewardable_id: answer.id,
                   rewardable_type: answer.class.name,
                   description: :best_answer,
                   points: answer_points)

      answer.answer_votes.each do |vote|
        Point.create(user_id: vote.user_id,
                     action: action,
                     rewardable_id: vote.id,
                     rewardable_type: vote.class.name,
                     description: :best_vote,
                     points: vote_points)   
      end     

    end

  # Source: https://github.com/ryanb/cancan/wiki/Accessing-Request-Data
  private

    # Required for CanCanCan Implementation
    def current_ability
      @current_ability ||= Ability.new(current_user, params)
    end

    # After Sign In redirect for Devise. 
    def after_sign_in_path_for(resource)
      questions_path
    end

end
