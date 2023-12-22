class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  before_action :cors_preflight_check
  respond_to :json
  
  def respond_with(current_user,_opts = {})
    if resource.persisted?
      render json: {
        status: {
          code: 200,
          message: 'Signed up successfully.'
        },
        data: {
          user: {
            id: current_user.id,
            name: current_user.name,
            email: current_user.email
          }
        }
      }
    else
      render json: {
        status: {
          message: "User couldn't be created successfully.
            #{current_user.errors.full_messages.to_sentence}"
        }
      }, status: :unprocessable_entity
    end
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = 'http://localhost:5173' # Update with the origin of your frontend application
      headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Content-Type'
      headers['Access-Control-Max-Age'] = '1728000'
      render json: {}, status: :ok
    end
  end
end
