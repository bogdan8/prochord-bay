class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can :read, :all
      can [:create], Song
    else
      can :read, :all
      can [:create], Song
    end
  end

  private
end
