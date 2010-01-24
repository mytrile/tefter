module SessionHelpers
  def current_user
    controller.send(:current_user)
  end

  def signed_in?
    controller.send(:signed_in?)
  end
end

World(SessionHelpers)
