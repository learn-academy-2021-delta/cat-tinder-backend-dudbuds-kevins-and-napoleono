require 'rails_helper'

RSpec.describe "Duds", type: :request do
  describe "GET /index" do
    it "gets a list of duds" do
      Dud.create name: 'Napolean', age: 44, hobbies: 'Comics'

      get '/duds'

      dud = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(dud.length).to eq 1
    end
  end

  describe "POST /create" do
    it 'creates a dud' do
      dud_params = {
        dud: {
          name: 'Mr Bean',
          age: 40,
          hobbies: 'Comedy'
        }
      }

      post '/duds', params: dud_params
      expect(response).to have_http_status(200)

      dud = Dud.first
      expect(dud.name).to eq 'Mr Bean'
      expect(dud.age).to eq 40
      expect(dud.hobbies).to eq 'Comedy'
    end
  end

  describe "PATCH /update" do
    it 'updates a dud' do
      dud_params = {
        dud: {
          name: 'Mr Bean',
          age: 40,
          hobbies: 'Comedy'
        }
      }
      post '/duds', params: dud_params
      dud = Dud.first

      updated_dud_params = {
        dud: {
          name: 'Mr Bean',
          age: 50,
          hobbies: 'Stupid Comedy'
        }
      }
      patch "/duds/#{dud.id}", params: updated_dud_params
      dud = Dud.first
      expect(response).to have_http_status(200)
      expect(dud.age).to eq 50
      expect(dud.hobbies).to eq 'Stupid Comedy'
    end
  end

  describe "DELETE /destroy" do
    it 'deletes a dud' do
      dud_params = {
        dud: {
          name: 'Mr Bean',
          age: 50,
          hobbies: 'Stupid Comedy'
        }
      }
      post '/duds', params: dud_params
      dud = Dud.first
      delete "/duds/#{dud.id}"
      expect(response).to have_http_status(200)
      duds = Dud.all
      expect(duds).to be_empty
    end
  end
end
