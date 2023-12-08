# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json
  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
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
end
