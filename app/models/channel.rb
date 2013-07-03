class Channel < ActiveRecord::Base
  has_many :messages
  has_and_belongs_to_many :users
  
  def self.for_users u1, u2
    channel_id = Channel.find_by_sql("SELECT channels_users.* FROM channels_users WHERE channels_users.user_id IN (#{u1.to_i},#{u2.to_i}) GROUP BY channel_id HAVING COUNT(*) > 1;").first.try(:channel_id)
    Channel.where(id: channel_id).first_or_create(user_ids: [u1, u2])
  end
end
