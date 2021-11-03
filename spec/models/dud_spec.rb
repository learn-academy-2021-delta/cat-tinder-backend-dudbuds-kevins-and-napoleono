require 'rails_helper'

RSpec.describe Dud, type: :model do
  it 'should validate name' do
    dud = Dud.create(age: 25, hobbies: 'Golf, Art, and Fast Cars')
    expect(dud.errors[:name]).to_not be_empty
  end
  it 'should have a valid age' do
    dud = Dud.create(name: 'Ricky', hobbies: 'Golf, Art, and Fast Cars')
    expect(dud.errors[:age].first).to eq "can't be blank"
  end
  it 'should have a valid hobbies' do
    dud = Dud.create(name: 'Ricky', age: 25)
    expect(dud.errors[:hobbies].first).to eq "can't be blank"
  end
  it 'should have a hobbies entry of at least 10 characters' do
    dud = Dud.create(name: 'Tim', age: 33, hobbies: 'Dance')
    expect(dud.errors[:hobbies].first).to eq 'is too short (minimum is 10 characters)'
  end
end
