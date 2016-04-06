class WelcomeController < ApplicationController
  #this define an 'action' called index for the WelcomeController
  def index
    #render text: "Hello world!"
    # by default (convention) rails will render:
    # view/wlecome/index.html.erb (when receving a request that has an HTML format)
    # you can also do:
    # render :index OR render "/some_other_folder/other_action"

    # if you use anotehr format by going to url such as "/home.text/"
    # rails will render a template according to that format so in the case of home.text' will be:

  end
  def about
    
  end
end
