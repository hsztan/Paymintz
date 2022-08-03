class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all, user_id: user.id
  end
end
