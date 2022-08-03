class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, Groups, user_id: user.id
    can :manage, Payments, user_id: user.id
    can :manage, Users, id: user.id
  end
end
