class StaticPagesController < ApplicationController
  def home
    if signin?
      @micropost = current_user.microposts.build
      # 定义一个实例变量给view
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
