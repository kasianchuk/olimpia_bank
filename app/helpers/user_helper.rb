module UserHelper
  def self.user_id_name
    User.all.map do |user|
      [user.name, user.id]
    end
  end
end
