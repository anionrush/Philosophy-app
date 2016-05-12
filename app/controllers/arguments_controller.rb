class ArgumentsController < ApplicationController
  def new
    @argument = Argument.new
  end

  def create
    @argument = Argument.new(argument_params)
 
     if @argument.save
      redirect_to @argument, notice: "argument was saved successfully."
     else
       flash.now[:alert] = "Error creating argument. Please try again."
       render :new
     end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
    if not (params[:search] and params[:search] != "")
      @arguments = Argument.all
    else
      @arguments = Argument.tagged_with("#{params[:search]}")
      params.delete :search
    end
  end

  def show
    @argument = Argument.find(params[:id])
  end

  private 

  def argument_params
    params.require(:argument).permit(:title, :tag_list, :premises)
  end

end
