class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can :read, :all
      can %i[create like], Song
      cannot %i[not_active do_active], Song
      cannot %i[do_admin do_user], User
      cannot :manage, Performer
    else
      can :read, :all
      can [:search], Song
      cannot %i[create like not_active do_active], Song
      cannot %i[do_admin do_user], User
      cannot :manage, Performer
    end
  end
end
