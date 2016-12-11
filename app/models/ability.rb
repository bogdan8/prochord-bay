class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can :read, :all
      can [:create, :like], Song
      cannot [:not_active, :do_active], Song
      cannot [:do_admin, :do_user], User
    else
      can :read, :all
      can [:search], Song
      cannot [:create, :like, :not_active, :do_active], Song
      cannot [:do_admin, :do_user], User
    end
  end
end
