class PremisesController < ApplicationController
  def new
    #creates sub_premise if params premise_id is not nil
    if params[:premise_id] != nil
      @parent_premise = Premise.find(params[:premise_id])
      @argument = Argument.find(params[:argument_id])
      @premise = @parent_premise.sub_premises.new
    #else creates main premise if params argument_id is not nil
    elsif params[:argument_id] != nil
      @argument = Argument.find(params[:argument_id])
      @premise = @argument.premises.new
    end
  end

  def create
    #creates sub_premise if params premise_id is not nil
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
    #else creates main premise if params argument_id is not nil
    elsif params[:argument_id] != nil
      @argument = Argument.find(params[:argument_id])
      @premise = @argument.premises.new(premise_params) 
     if @premise.save
      redirect_to edit_argument_path(@argument), notice: "Premise was saved successfully."
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
    flash[:notice] = "Premise was updated."
     redirect_to edit_argument_path(@argument)
   else
     flash.now[:alert] = "Error saving premise. Please try again."
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
      flash.now[:alert] = "There was an error deleting the premise."
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
