class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :show, :vote]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all.sort_by{ |votes| votes.total_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def vote
    vote = Vote.create(voteable: @post, user_id: current_user, vote: params[:vote])
    if vote.valid?  
      flash[:notice] = "Your vote is counted"
    else
      flash[:error] = "You can only vote in a post once"
    end
    redirect_to :back

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      #binding.pry
      flash[:notice] = "Your Post was created"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your Post was Updated"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end


end
