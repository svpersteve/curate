class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to @notification.notifiable
  end

  def mark_all_read
    current_user.notifications.unread.each do |n|
      n.update read: true
    end
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
end
