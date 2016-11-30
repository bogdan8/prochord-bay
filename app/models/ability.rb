class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can :read, :all
      can [:create, :like], Song
    else
      can :read, :all
      cannot [:create, :like], Song
    end
  end

  private
end
