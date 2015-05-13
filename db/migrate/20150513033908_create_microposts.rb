class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps # 自动创建created_at和updated_at
    end
    
    add_index :microposts, [:user_id, :created_at]
  end
  
end
