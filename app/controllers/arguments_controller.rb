class ArgumentsController < ApplicationController
  def new
    @argument = Argument.new
  end

  def create
    @argument = Argument.new(argument_params)
 
     if @argument.save
      redirect_to edit_argument_path(@argument), notice: "argument was saved successfully."
     else
       flash.now[:alert] = "Error creating argument. Please try again."
       render :new
     end
  end

  def update
    @argument = Argument.find(params[:id])
  
    @argument.title = argument_params[:title]
    @argument.tag_list.split.each do |tag|
      @argument.tag_list.remove(tag)
    end
    argument_params[:tag_list].split.each do |tag|
      @argument.tag_list.add(tag, parse: true)
    end

   if @argument.save
    flash[:notice] = "argument was updated."
     redirect_to @argument
   else
     flash.now[:alert] = "Error saving argument. Please try again."
     render :edit
   end
  end

  def edit
    @argument = Argument.find(params[:id])
  end

  def destroy
    @argument = Argument.find(params[:id])

    if @argument.destroy
      flash[:notice] = "\"#{@argument.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the argument."
      render :show
    end
  end

  def index
    if not (params[:search] and params[:search] != "")
      @arguments = Argument.paginate(:page => params[:page], :per_page => 12)
    else
      @arguments = Argument.tagged_with("#{params[:search]}").paginate(:page => params[:page], :per_page => 12)

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
