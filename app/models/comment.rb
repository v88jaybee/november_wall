class Comment < ApplicationRecord
    include QueryHelper

    belongs_to :message
    belongs_to :user

    def self.create_comment(comment_params, user_id)
        comment_result = {:status => false, :result => nil, :message => nil}

        if comment_params[:comment_text].present?
            insert_query = ["INSERT INTO comments (message_id, user_id, comment, created_at, updated_at) 
                        VALUES (?, ?, ?, NOW(), NOW())", comment_params[:message_id], user_id, comment_params[:comment_text]]
            
            new_comment = insert_record(insert_query)

            if new_comment.present?
                comment_result[:status] = true
            else  
                comment_result[:message] = "Error while creating new message"
            end
        else
            comment_result[:message] = "Message is required"
        end

        return comment_result
    end

    def self.delete_comment(comment_params, user_id)
        comment_result = {:status => false, :result => nil, :message => nil}

        if comment_params[:comment_id].present?
            delete_query = ["DELETE FROM comments WHERE id =? AND user_id =?", comment_params[:comment_id], user_id]
            delete_record = delete_record(delete_query)

            if delete_record
                comment_result[:status] = true
            else  
                comment_result[:message] = "Error while deleting comment"
            end
        else
            comment_result[:message] = "Comment ID is required"
        end

        return comment_result
    end

    def self.delete_comment_by_message_id(message_id)
        comment_result = {:status => false, :result => nil, :message => nil}

        delete_query = ["DELETE FROM comments WHERE message_id =?", message_id]
        delete_record = delete_record(delete_query)

        if delete_record
            comment_result[:status] = true
        else  
            comment_result[:message] = "Error while deleting comment"
        end

        return comment_result
    end


end
