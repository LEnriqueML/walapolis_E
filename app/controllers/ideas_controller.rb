class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :verify_ownership, only: [:edit, :update, :destroy]
  before_action :set_categories
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.where(user_id: current_user.id)
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @comments = Comment.where(idea_id: @idea)
    @comment = Comment.new(idea_id: @idea.id)
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
    @categories = Category.all
  end

  # GET /ideas/1/edit
  def edit
    if @idea.user_id != current_user.id
      redirect_to root_path, alert: '¡La idea que quieres modificar no te pertenece!' 
    end
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    respond_to do |format|
      if @idea.save
        print_benefits
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    if @idea.user_id = current_user.id
      respond_to do |format|
        if @idea.update(idea_params)
          print_benefits
          format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
          format.json { render :show, status: :ok, location: @idea }
        else
          format.html { render :edit }
          format.json { render json: @idea.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end
     
    def verify_ownership
      redirect_to root_path, alert: "Acceso denegado" if @idea.user_id != current_user.id
    end

    def set_categories
     @categories = Category.all
    end

    def print_benefits
      puts @idea.benefits
      puts @idea.benefits.count
    end

    def idea_comments
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:title, :body, :initial_cost, :monthly_cost, :estimated_time, benefits:[], category_ids:[])
    end
end
