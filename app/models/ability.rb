class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
      can :create, Post
    end

    can :manage, User, id: user.id
    can :manage, Post, author_id: user.id
    can :manage, Tag, creator_id: user.id
    can :manage, Like, fan_id: user.id
  end
end
