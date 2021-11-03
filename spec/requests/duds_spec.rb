require 'rails_helper'

RSpec.describe "Duds", type: :request do
  describe "GET /index" do
    it "gets a list of duds" do
      Dud.create name: 'Napolean', age: 44, hobbies: 'Comics books'

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
          hobbies: 'Comedy and dance'
        }
      }

      post '/duds', params: dud_params
      expect(response).to have_http_status(200)

      dud = Dud.first
      expect(dud.name).to eq 'Mr Bean'
      expect(dud.age).to eq 40
      expect(dud.hobbies).to eq 'Comedy and dance'
    end
  end

  describe "PATCH /update" do
    it 'updates a dud' do
      dud_params = {
        dud: {
          name: 'Mr Bean',
          age: 40,
          hobbies: 'Comedy and dance'
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
  describe 'dud validation error codes' do
    it 'does not create a dud without a name' do
      dud_params = {
        dud: {
          age: 21,
          hobbies: 'Playing Guitar'
        }
      }
      post '/duds', params: dud_params 
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
    end
    it 'does not create a dud with an age' do
      dud_params = {
        dud: {
          name: 'Tim',
          hobbies: 'Comics'
        }
      }
      post '/duds', params: dud_params
      expect(response).to have_http_status(422)
      dud = JSON.parse(response.body)
      expect(dud['age']).to include "can't be blank"
    end
    it 'does not create a dud without a hobbies' do
      dud_params = {
        dud: {
          name: 'Tim',
          age: 33
        }
      }
      post '/duds', params: dud_params
      expect(response).to have_http_status(422)
      dud = JSON.parse(response.body)
      expect(dud['hobbies']).to include "can't be blank"
    end
  end
  describe "cannot update a dud without valid attributes" do
    it 'cannot update a dud without a name' do
      dud_params = {
        dud: {
          name: 'Ricky',
          age: 25,
          hobbies: 'Golf, Art, and Fast Cars'
        }
      }
      post '/duds', params: dud_params
      dud = Dud.first
      dud_params = {
        dud: {
          name: '',
          age: 25,
          hobbies: 'Golf, Art, and Fast Cars'
        }
      }
      patch "/duds/#{dud.id}", params: dud_params
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json['name']).to include "can't be blank"
    end
    it 'cannot update a dud without a age' do
      dud_params = {
        dud: {
          name: 'Ricky',
          age: 25,
          hobbies: 'Golf, Art, and Fast Cars'
        }
      }
      post '/duds', params: dud_params
      dud = Dud.first
      dud_params = {
        dud: {
          name: 'Ricky',
          age: '',
          hobbies: 'Golf, Art, and Fast Cars'
        }
      }
      patch "/duds/#{dud.id}", params: dud_params
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json['age']).to include "can't be blank"
    end
    it 'cannot update a dud without a hobbies' do
      dud_params = {
        dud: {
          name: 'Ricky',
          age: 25,
          hobbies: 'Golf, Art, and Fast Cars'
        }
      }
      post '/duds', params: dud_params
      dud = Dud.first
      dud_params = {
        dud: {
          name: 'Ricky',
          age: 25,
          hobbies: '',
        }
      }
      patch "/duds/#{dud.id}", params: dud_params
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json['hobbies']).to include "can't be blank"
    end
  end

end
