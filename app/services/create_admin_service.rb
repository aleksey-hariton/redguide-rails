class CreateAdminService
  def call
    User.find_or_create_by!(email: Rails.application.secrets.admin_email,
                            name: Rails.application.secrets.admin_name) do |user|
      user.password = Rails.application.secrets.admin_password
      user.password_confirmation = Rails.application.secrets.admin_password
      user.admin!
    end
  end

  def handler
    User.find_or_create_by!(name: Rails.application.secrets.handler_name) do |h|
      h.password = Rails.application.secrets.handler_password
      h.password_confirmation = Rails.application.secrets.handler_password
      h.email = Rails.application.secrets.handler_email
      h.user!
    end
  end
end
