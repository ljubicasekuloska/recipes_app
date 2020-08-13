require 'rails_helper'

RSpec.describe "Users" do
  it "creates a User and redirects to the User's page" do
    get '/users/signup'

    expect(response).to render_template(:new)

    post_params = {
      params: {
        user: {
          handle: 'Bube',
          email: 'bube@bube.com',
          first_name: 'Bube',
          last_name: 'Sekuloska',
          password: 'testtest',
          password_confirmation: 'testtest'
        }
      }
    }

    post '/users', post_params

    expect(session[:user_id]).not_to be_nil
    expect(response).to redirect_to(assigns(:user))

    follow_redirect!
    expect(response).to render_template(:show)

    expect(response.body).to include('Bube')
    expect(response.body).to include('bube@bube.com')
    expect(response.body).to include('Sekuloska')
  end

  it "renders New when User params are empty" do
    get '/users/signup'

    post_params = {
      params: {
        user: {
          handle: '',
          email: '',
          first_name: '',
          last_name: '',
          password: '',
          password_confirmation: ''}
      }
    }

    post '/users', post_params

    expect(session[:user_id]).to be_nil
    expect(response).to render_template(:new)
  end
end