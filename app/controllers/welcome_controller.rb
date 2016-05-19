class WelcomeController < ApplicationController
  def index
  	@arguments=Argument.all
  end
end
