class DeleteUnconfirmedUsersJob < ActiveJob::Base
  def perfom
    User.unconfirmed.expired.destroy_all
  end
end