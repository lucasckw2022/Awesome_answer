class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    #because this time has only 1 thing to pass so not necessarily to use strong params
    vote = Vote.new(is_up: params[:vote][:is_up],
                    question: question,
                    user: current_user)
    # vote.question = question
    # vote.user = current_user
    vote.save
    if vote.save
      #question = question_path(question)
      redirect_to question, notice: "You have voted sucessfully!"
    else
      redirect_to question, notice: "Failed to vote! Please try again!"
    end
  end

  def update
    # vote = current_user.votes.find params[:id]
    if vote.update(is_up: params[:vote][:is_up])
      redirect_to question, notice: "Vote Changed!"
    else
      redirect_to question, notice: "Failed to change vote!"
    end
  end

  def destroy
    # vote = current_user.votes.find params[:id]
    vote.destroy
    # redirect_to question_path(question), notice: "Vote Undone!"
    redirect_to question, notice: "Vote Undone!"
  end

  private

  def question
    @question ||= Question.find params[:question_id]
  end

  def vote
    vote = current_user.votes.find params[:id]
  end
end
