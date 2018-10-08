class NotificationsController < ApplicationController

  before_action :authenticate_user_from_token!, only: [:mark_as_read]

  # GET /users/:id/notifications
  def index
    @notifications = User.find(params[:user_id]).received_notifications.order(created_at: :desc).limit(20)
    render json: NotificationSerializer.new(@notifications).serialized_json
  end

  # POST /notifications/:id/mark_as_read
  def mark_as_read
    notification = Notification.find(params[:id])

    if notification.receiver_id != current_user.id
      render json: { error: I18n.t('Unauthorized - mark_notification_as_completed_error') }, status: :forbidden
      return
    end

    notification.read = true
    if notification.save
      render json: true
    else
      render json: false
    end
  end

end
