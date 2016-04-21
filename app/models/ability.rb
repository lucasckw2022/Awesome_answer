class Ability
  include CanCan::Ability

  # CanCanCan automatically integrates with ApplicationController and it assumes
  # that you have a method in your ApplicationController called `current_user`
  # you don't need to automatically create an Ability object (automatically done)
  # we just need to learn how to write authorization rule and how to use them
  def initialize(user)
    # we intantiate the user to User.new to avoid have user be nil if the user
   # is not signed in. We assume here that `user` will be `User.new` if the
   # user is not signed in.
   user ||= User.new

   # this gives superpowers to the admin user by having the ability to manage
    # everything (all actions on all models)
   can :manage, :all if user.admin?

   alias_action :create, :read, :update, :destroy, :to => :crud

   # defining the ability to :manage (do anything) with a question
    # in the case below we put inside the block an expression that will return
    # true or false. This will determine whether the user is allowed to curd
    # a question or not (create, read, update and destroy)
    # can also do :edit/ :destroy
    # Question is the model name
   can :crud, Question do |q|
     q.user == user && user.persisted?
   end

   can :crud, Answer do |a|
     (a.user == user || a.question.user == user) && user.persisted?
   end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
