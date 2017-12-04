module ActiveAdmin::ViewsHelper #camelized file name
  def button_restriction_checker(proposal, states)
    states.include?(proposal.aasm_state ) && proposal.admin_user == current_admin_user
  end
end 