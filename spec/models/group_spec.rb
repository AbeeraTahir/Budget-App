require 'rails_helper'

RSpec.describe Group, type: :model do
  subject do
    @user = User.create(name: 'Abeera', email: 'abeera@gmail.com', password: '123456')
    @group = Group.create(name: 'food', icon: nil, user: @user)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should have valid value' do
    expect(subject.name).to eql 'food'
  end

  it 'user should be present' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'can have an attached icon' do
    expect(subject).to respond_to(:icon)
  end
end