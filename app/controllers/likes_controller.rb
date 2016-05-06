class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_create, only: :create
  before_action :authorize_destroy, only: :destroy
  before_action :question # this will call the `question` method to force
                          # finding the question as we will need it for both
                          # the create and destroy actions
  def create
    question = Question.find params[:question_id]
    like = Like.new
    like.user = current_user
    like.question = question
    respond_to do |format|
    if like.save
      format.html{
        redirect_to question, notice: "liked"
      }
      format.js {render} #likes/create.js.erb
    #this is short cut`
  else
    format.html{
      redirect_to question, notice: "You're already liked!"
    }
    format.js {render js: "alert(Can't like, please refresh the page!);"}
    end
  end
  end

  def destroy
    question = Question.find params[:question_id]
    like = Like.find params[:id]
    like.destroy
    question
    respond_to do |format|
      format.html{
        endredirect_to question, notice: "Un-liked"
      }
      format.js{render}
    end
  end

  private

    def authorize_create
      redirect_to question, notice: "you can't like" unless can? :like, question
    end

    def authorize_destroy
        redirect_to question, notice: "you can't Un-Like" unless can? :destroy, like
    end

    def question
      @question ||= Question.find params[:question_id]
    end

    def like
      @like ||= Like.find params[:id]
    end

end
