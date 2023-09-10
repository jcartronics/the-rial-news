class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user
    
        if @comment.save
            redirect_to @post, notice: 'Comentario agregado correctamente.'
          else
            render 'posts/show'
          end
    end

    def destroy
        @comment = Comment.find(params[:id])

        if current_user == @comment.user || current_user == @comment.post.user || current_user.admin?
            @comment.destroy
            redirect_to @comment.post, notice: 'Comentario eliminado correctamente.'
          else
            redirect_to @comment.post, alert: 'No tienes permiso para eliminar este comentario.'
          end
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end