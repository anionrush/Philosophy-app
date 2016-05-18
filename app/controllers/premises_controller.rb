class PremisesController < ApplicationController
  def new
    if params[:premise_id] != nil
      @parent_premise = Premise.find(params[:premise_id])
      @argument = Argument.find(params[:argument_id])
      @premise = @parent_premise.sub_premises.new
    elsif params[:argument_id] != nil
      @argument = Argument.find(params[:argument_id])
      @premise = @argument.premises.new
    end
  end

  def create
    if params[:premise_id] != nil
      @parent_premise = Premise.find(params[:premise_id])
      @premise = @parent_premise.sub_premises.new(:body => params[:premise][:body], :parent_premise_id => @parent_premise.id)

      if @premise.save
        @argument = Argument.find(params[:argument_id])
        redirect_to edit_argument_path(@argument), status: 301, notice: "Subpremise was saved successfully."
       else
         flash.now[:alert] = "Error creating subpremise. Please try again."
         render :new
      end

    elsif params[:argument_id] != nil
      @argument = Argument.find(params[:argument_id])
      @premise = @argument.premises.new(premise_params) 
     if @premise.save
      redirect_to edit_argument_path(@argument), notice: "premise was saved successfully."
     else
       flash.now[:alert] = "Error creating premise. Please try again."
       render :new
     end
  
    end
  end

  def update
    @premise = Premise.find(params[:id])
    @premise.body = premise_params[:body]

   if @premise.save
    @argument = Argument.find(params[:argument_id])
    flash[:notice] = "argument was updated."
     redirect_to edit_argument_path(@argument)
   else
     flash.now[:alert] = "Error saving argument. Please try again."
     render :edit
   end
  end

  def edit
    @premise = Premise.find(params[:id])
    @argument = Argument.find(params[:argument_id])
  end

  def destroy
    @premise = Premise.find(params[:id])

    if @premise.destroy
      @argument = Argument.find(params[:argument_id])
      flash[:notice] = "\"#{@premise.body}\" was deleted successfully."
      redirect_to edit_argument_path(@argument)
    else
      flash.now[:alert] = "There was an error deleting the argument."
      redirect_to edit_argument_path(@argument)
    end
  end

  def index
  end

  def show
  end

  private 

  def premise_params
    params.require(:premise).permit(:body, :parent_premise_id)
  end

end
