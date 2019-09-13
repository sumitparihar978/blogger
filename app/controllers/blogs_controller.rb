class BlogsController < ApplicationController
	before_action :set_blog, only: [:show, :edit, :update, :destroy, :upvote]

	# GET /blogs
	# GET /blogs.json
	def index
		@blogs = current_user.blogs.all.paginate(page: (params[:page] || 1), per_page: 20)
	end

	# GET /blogs/1
	# GET /blogs/1.json
	def show
	end

	# GET /blogs/new
	def new
		@blog = current_user.blogs.new
	end

	# GET /blogs/1/edit
	def edit
	end

	# POST /blogs
	# POST /blogs.json
	def create
		@blog = current_user.blogs.new(blog_params)

		respond_to do |format|
			if @blog.save
				format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
				format.json { render :show, status: :created, location: @blog }
			else
				format.html { render :new }
				format.json { render json: @blog.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /blogs/1
	# PATCH/PUT /blogs/1.json
	def update
		respond_to do |format|
			if @blog.update(blog_params)
				format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
				format.json { render :show, status: :ok, location: @blog }
			else
				format.html { render :edit }
				format.json { render json: @blog.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /blogs/1
	# DELETE /blogs/1.json
	def destroy
		@blog.destroy
		respond_to do |format|
			format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	def my_blogs
		@blogs = current_user.blogs.all.paginate(page: (params[:page] || 1), per_page: 20)
	end

	def upvote
		@vote = @blog.votes.find_by(voter_id: current_user.id)
		if @vote.present?
			@vote.destroy
		else
			@vote = @blog.votes.create(voter_id: current_user.id)
		end
	end

	private
	
	# Use callbacks to share common setup or constraints between actions.
	def set_blog
		@blog = current_user.blogs.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def blog_params
		params.require(:blog).permit(:name, :description, image_attributes: [:id, :attachment])
	end
end