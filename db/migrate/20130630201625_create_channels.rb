class CreateChannels < ActiveRecord::Migration
  def up
    create_table :channels do |t|

      t.timestamps
    end
    
    create_table :channels_users do |t|
      t.belongs_to :user
      t.belongs_to :channel
    end
  end
  
  def down
    drop_table :channels
    drop_table :channels_users
  end
end
