class Users::SessionsController < Devise::SessionsController
  layout 'authentication', only: [:new]
end
