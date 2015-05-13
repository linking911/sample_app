module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    # ��Ϊ����Ҫ���õ�20��� ͬcookies[:remember_token] = {value: remember_token, expires:20.years.from_now.utc}
    cookies.permanent[:remember_token] = remember_token
    # ʹ��update_attribute�����֤���浥һ���
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  
  # Accessor����
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    # �����ڣ� ������
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
  
  def current_user?(user)
    user == current_user
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def signed_in_user
    # ��ͬ�ڣ� flash[:notice]="Please sign in."
    # flash[:notice], flash[:success], flash[:error]
    # redirect_to signin_url, notice: "Please sign in." unless signin?
    unless signin?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  
end
