class PostCommentsController < ApplicationController
  before_action :set_post_comment, only: [:destroy]

  # POST /post_comments
  # POST /post_comments.json
  def create
    @post_comment = PostComment.new(post_comment_params)
    if user_signed_in?
      @post_comment.user_id = current_user.id

      respond_to do |format|
        if @post_comment.save
          format.html { redirect_to @post_comment.post, notice: 'Комментарий успешно добавлен.' }
          format.json { render :show, status: :created, location: @post_comment }
        else
          format.html { redirect_to @post_comment.post, notice: 'Error.' }
          format.json { render json: @post_comment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to @post_comment.post, notice: 'Комментарии могут оставлять только зарегистрированные пользователи.' }
          format.json { render json: ['Комментарии могут оставлять только зарегистрированные пользователи.'], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_comments/1
  # DELETE /post_comments/1.json
  def destroy
    post = @post_comment.post
    @post_comment.destroy
    respond_to do |format|
      format.html { redirect_to post, notice: 'Комментарий удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_comment
      @post_comment = PostComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_comment_params
      params.require(:post_comment).permit(:content, :post_id)
    end
end
