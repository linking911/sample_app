require 'rails_helper'

RSpec.describe Micropost, :type => :model do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # @micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
    # 关联后， 用这种方式创建关联对象， 会自动设置关联数据
    @micropost = user.microposts.build(content: "Lorem ipsum")
  end
  
  subject { @micropost }
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  # 应该会生成user属性
  it { should respond_to(:user) }
  # micropost的user属性应该返回User对象
  its(:user) { should eq user }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    # Set user_id to nill
    before { @micropost.user_id = nil }
    
    # Validate the valid?
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @micropost.content = " " }
    
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    # 长度不能超过140
    before { @micropost.content = "a" *141 }
    
    it { should_not be_valid }
  end
  
end
