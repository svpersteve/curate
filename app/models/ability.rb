class Ability
  include CanCan::Ability

  def initialize(user) # rubocop:disable Metrics/MethodLength
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
      can :manage, User, id: user.id
      can :manage, Post, author_id: user.id
      can :manage, Tag, creator_id: user.id
      can :create, Post
      can :publish, Post
      can :like, Post
      can :unlike, Post
      can :create, Artwork
      can :like, Artwork
      can :unlike, Artwork
      can :manage, Artwork, artist_id: user.id
    end
  end
end
