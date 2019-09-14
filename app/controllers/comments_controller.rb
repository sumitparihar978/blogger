class CommentsController < ApplicationController
  before_action :set_blog
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = @blog.comments.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = @blog.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.source_id = @blog.id
    @comment.user = current_user
    if @comment.commentable.is_a?(Comment)
      @comments = @comment.commentable.replies.as_created
    else
      @comment.commentable = @blog 
      @comments = @blog.comments.as_created 
    end

    respond_to do |format|
      if @comment.save
        @comment = Comment.new(
            commentable_id: @comment.commentable_id , 
            commentable_type: 'Comment'
        )
        format.html { redirect_to comments_path, notice: 'Comment was successfully created.' }
        format.js { render :create }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.js { render :create }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
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
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def view_replies
    @comment = Comment.where(id: params[:comment_id] ,source_id: @blog.id ).first
    @target = Comment.new(
        commentable_id: @comment.id , 
        commentable_type: 'Comment'
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = @blog.comments.find(params[:id])
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end
end
