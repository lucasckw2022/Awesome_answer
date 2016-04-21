class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # defining a method in as a `before_action` will make it so that Rails
  # executes that method before executing the action. This is still within
  # the same request cycle
  # you can give the `before_action` method two options: :only or :except
  # this will help you limit the actions which the `find_question` method will
  # be executed before.
  # in the code below `find_question` will only be executed before: show, edit
  # update and destroy actions

  # before_action(:find_question, {only: [:show, :update, :destroy]})

  before_action :find_owned_question, only: [:edit,:update,:destroy]
  before_action :find_question, only: [:edit,:update,:destroy,:show]

  def new
    # we need to define a new `Question` object in order to be able to
    # properly generate a form in Rails
    # Question is the ActiveRecord model
    @question = Question.new
    @question.user = current_user
  end

  def create
    # Method 1
    # @question       = Question.new
    # @question.title = params[:question][:title]
    # @question.body  = params[:question][:body]
    # @question.save!

    # Method 2
    # @question = Question.create({title: params[:question][:title],
    #                              body:  params[:question][:body]})

    # Method 3
    # params[:question] looks like: {"title"=>"question from web", "body"=>"question body from web"}
    # @question = Question.create(params[:question])
    # this will throw a: ActiveModel::ForbiddenAttributesError exception


    # Method 4
    # we use Strong Parameters feature of Rails
    @question       = Question.new(question_params)
    @question.user  = current_user
    if @question.save
      flash[:notice] = "Question created!"
      # render :show
      # redirect_to question_path({id: @question.id})
      redirect_to question_path(@question)
    else
      flash[:alert] = "Question didn't save!"
      # this will render `app/views/questions/new.html.erb` because the default
      # in this action is to render `app/views/questions/create.html.erb`
      render :new
    end
  end

  # we receive a request such as : GET /questions/56
  # params[:id] will be `56`
  def show
    @answer = Answer.new
  end

  def index
    @questions = Question.all
  end

  def edit
    # @question = current_user.questions.find params[:id]
  end

  def update
    if @question.update question_params
      # flash messages can be set either directly using: flash[:notice] = ".."
      # you can also pass a `:notice` or `:alert` options to the `redirect_to`
      # method.
      redirect_to question_path(@question), notice: "Question updated!"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Question: #{@question.title} deleted!"
  end

  private

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit([:title, :body])
  end

  def find_owned_question
    @question = current_user.questions.find params[:id]
  end

  def user_like
    @user_like ||= @question.like_for(current_user)
  end
  helper_method :user_like

end
