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
  end

  def edit
  end

  def destroy
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
