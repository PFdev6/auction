class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all   
    if user.present?
      can :manage, User, id: user.id
      can :manage, Lot, user_id: user.id, inprocess: true
      can :read, CurrentBargain, user_id: user.id
      can :read, MainNews, user_id: user.id
    end
    if user && user.isadmin?
      can :manage, :all
    end
  end
end
