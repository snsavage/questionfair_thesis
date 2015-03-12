class Ability
  include CanCan::Ability

  def initialize(user, params)

    alias_action :update, :destroy, :to => :modify

    user ||= User.new

    # Abilities for Question
    can :search, Question
    can :read, Question
    can :create, Question
    can :modify, Question, user_id: user.id

    # Abilities for Answer
    can :create, Answer if has_ability_to_create_answer(params, user) 
    can :modify, Answer, user_id: user.id

  end

  private
    def has_ability_to_create_answer(params, user)
      if params[:controller] == ("questions") && params[:action] == "show"
        Question.find(params[:id]).user_id != user.id
      elsif params[:controller] == ("answers") && params[:action] == "create"
        Question.find(params[:question_id]).user_id != user.id
      else
        false
      end
    end

end
