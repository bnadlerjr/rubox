class User
  attr_accessor :login,           :email,        :access_id,
                :user_id,         :space_amount, :space_used,
                :max_upload_size

  def initialize
    yield self if block_given?
  end

  def self.load_from_xml(xml)
    User.new do |u|
      u.login = xml['user']['login'].to_s
      u.email = xml['user']['email'].to_s
      u.access_id = xml['user']['access_id'].to_i
      u.user_id = xml['user']['user_id'].to_i
      u.space_amount = xml['user']['space_amount'].to_i
      u.space_used = xml['user']['space_used'].to_i
      u.max_upload_size = xml['user']['max_upload_size'].to_i
    end
  end
end
