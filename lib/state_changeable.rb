module StateChangeable

  def universal_callback
    state_changed_callback(self)
  end

  def action_needed?(resource)
    resource.class::ActionRequirements[aasm_state]
  end

  def state_changed_callback(resource)
    set_event_status resource
    need_action resource
    resource.save
  end

  def state_notification
    send_notification(self)
  end

  def special_notification
    send_special_notification(self)
  end

  def set_event_status(resource)
    resource.status = Status.by_code( resource.aasm_state, resource.class.to_s.downcase)
  end

  def need_action(resource)
    resource.action = action_needed? resource
  end

  protected

  def send_notification(resource)
    if action_needed?(resource)
      Notification::ManagerNotificationService.make_notification(resource)
    end
  end

  def send_special_notification(resource)
    Notification::UserNotificationService.special_notification(resource)
  end
end