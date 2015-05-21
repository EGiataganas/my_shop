class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

=begin 
  # This is how we can do it using scope and not self methods
  scope :unconfirmed, -> { where(confirmed_at: nil) }
  scope :expired, -> { unconfirmed.where(arel_table[:created_at].lt(2.weeks.ago)) }
=end 

  class << self
    def unconfirmed
      where(confirmed_at: nil)
    end

    def expired(expired_at = 2.weeks.ago)
      where(arel_table[:created_at].lt(expired_at))
    end

    def matches_name(name)
      where(arel_table[:name].matches(name))
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
