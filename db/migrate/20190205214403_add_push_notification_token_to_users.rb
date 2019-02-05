class AddPushNotificationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :push_notification_token, :string
  end
end
