class WallsController < ApplicationController
    before_action do
        if !signed_in?
            redirect_to "/login"
        end
    end
    
    def index
        @current_user = current_user 
        @all_messages = Message.fetch_all_messages_comments
    end

    def create_message
        render :json => Message.create_message(message_params, current_user["id"])
    end

    def delete_message
        render :json => Message.delete_message(delete_message_params, current_user["id"])
    end

    def create_comment
        render :json => Comment.create_comment(comment_params, current_user["id"])
    end

    def delete_comment
        render :json => Comment.delete_comment(delete_comment_params, current_user["id"])
    end

    private
        def message_params 
            params.require(:message).permit(:message_text)
        end

        def delete_message_params 
            params.require(:message).permit(:message_id)
        end

        def comment_params 
            params.require(:comment).permit(:message_id, :comment_text)
        end

        def delete_comment_params 
            params.require(:comment).permit(:comment_id)
        end
end
