module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    # 因为经常要设置到20年后， 同cookies[:remember_token] = {value: remember_token, expires:20.years.from_now.utc}
    cookies.permanent[:remember_token] = remember_token
    # 使用update_attribute跳过验证保存单一数据
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  
  # Accessor方法
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    # 如果存在， 不用找
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  def signin?
    user = current_user
    !user.nil?
  end
  
  def signout
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
end
