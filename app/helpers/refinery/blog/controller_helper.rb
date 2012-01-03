module Refinery
  module Blog
    module ControllerHelper
    
      protected
    
        def find_blog_post
          unless (@blog_post = Refinery::Blog::Post.find(params[:id])).try(:live?)
            if refinery_user? and current_refinery_user.authorized_plugins.include?("refinerycms_blog")
              @blog_post = Refinery::Blog::Post.find(params[:id])
            else
              error_404
            end
          end
        end
    
        def find_all_blog_posts
          @blog_posts = Refinery::Blog::Post.live.includes(:comments, :categories).page(params[:page])
        end

        def find_tags
          @tags = Refinery::Blog::Post.tag_counts_on(:tags)
        end
      
        def find_all_blog_categories
          @blog_categories = Refinery::Blog::Category.all
        end
    end
  end
end