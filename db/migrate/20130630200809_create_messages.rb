class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.belongs_to :channel
      t.string :body

      t.timestamps
    end
  end
end
