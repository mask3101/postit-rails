class CommentsController < ApplicationController
before_action :require_user
  def create
    @post = Post.find_by slug: params[:post_id]
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user
    
    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, user_id: current_user.id, vote: params[:vote])
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote is counted"
        else
          flash[:error] = "You can only vote in a comment once"
        end
        redirect_to :back
      end
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end