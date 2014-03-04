SimpleConfig.for :application do
  group :services do
    set :sign_in, 'http://localhost:5000/users/sign_in'
    set :current_user, 'http://localhost:5000/users/current_user'
  end
end
