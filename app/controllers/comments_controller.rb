class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :verify_ownership, only: [:edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to idea_path(@comment.idea), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to idea_path(@comment.idea), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    idea = @comment.idea.id
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to idea_path(idea), notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to idea_path(@comment.idea), alert: {class: 'alert-danger', body: "Este intento de violación de datos personales infringe la Ley Federal de Transparencia y Acceso a la Información y Protección de Datos Personales por lo que se ha realizado la denuncia correspondiente ante la Procudaría General de la República (PGR) y ha quedado asentada en la carpeta de investigación PGR/#{Time.zone.now.year}/#{Time.zone.now.month}/#{Time.zone.now.day}/#{rand(1000)} >:-("}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def verify_ownership
      redirect_to root_path, alert: {class: 'alert-danger', body: "Este intento de violación de datos personales infringe la Ley Federal de Transparencia y Acceso a la Información y Protección de Datos Personales por lo que se ha realizado la denuncia correspondiente ante la Procudaría General de la República (PGR) y ha quedado asentada en la carpeta de investigación PGR/#{Time.zone.now.year}/#{Time.zone.now.month}/#{Time.zone.now.day}/#{rand(1000)} >:-("} if @comment.user_id != current_user.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :idea_id, :body)
    end
end
