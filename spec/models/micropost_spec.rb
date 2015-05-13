require 'rails_helper'

RSpec.describe Micropost, :type => :model do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # @micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
    # ������ �����ַ�ʽ������������ ���Զ����ù�������
    @micropost = user.microposts.build(content: "Lorem ipsum")
  end
  
  subject { @micropost }
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  # Ӧ�û�����user����
  it { should respond_to(:user) }
  # micropost��user����Ӧ�÷���User����
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
    # ���Ȳ��ܳ���140
    before { @micropost.content = "a" *141 }
    
    it { should_not be_valid }
  end
  
end
