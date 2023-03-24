require 'rails_helper'

RSpec.describe Expense, type: :model do
  subject do
    @user = User.create(name: 'Abeera', email: 'abeera@gmail.com', password: '123456')
    @expense = Expense.create(name: 'food', amount: 10.0, user: @user)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should have valid value' do
    expect(subject.name).to eql 'food'
  end

  it 'amount should be present' do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it 'amount should have valid value' do
    expect(subject.amount).to eql 10.0
  end

  it 'amount should not be less than 0' do
    subject.amount = -1.0
    expect(subject).to_not be_valid
  end

  it 'user should be present' do
    subject.user = nil
    expect(subject).to_not be_valid
  end
end
