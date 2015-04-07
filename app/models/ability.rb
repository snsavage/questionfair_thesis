# Definitions of Authorization abilities. 
class Ability
  include CanCan::Ability

  def initialize(user, params)

    alias_action :update, :destroy, :to => :modify

    user ||= User.new

    # Abilities for Question
    can :search, Question
    can :geo_search, Question
    can :read, Question
    can :create, Question
    can :modify, Question, user_id: user.id

    # Abilities for User
    can :index, User
    can :show, User
    
    # Abilities for Answer
    can :create, Answer
    cannot :create, Answer, :question => { :user_id => user.id }
    can :modify, Answer, user_id: user.id
    can :vote, Answer
    can :unvote, Answer
    can :best, Answer, question: { user_id: user.id }

    # Abilities for Friendship
    can :create, Friendship
    can :update, Friendship, user_id: user.id
    can :destroy, Friendship, user_id: user.id

  end

end
