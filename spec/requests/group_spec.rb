require 'rails_helper'

RSpec.describe 'Groups page', type: :system do
  describe 'Groups /index' do
    before(:each) do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @group = Group.create(name: 'food', icon: nil, user: @user)
      #@food2 = Food.create!(name: 'food2', measurement_unit: 'grams', quantity: 7, price: 20, user_id: @user.id)
      @user.skip_confirmation!
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(1)
      visit groups_path
    end

    after(:each) do
      sleep(2)
    end

    it 'displays the name, date, amount of group' do
      expect(page).to have_content(@group.name)
      expect(page).to have_content(@group.created_at.strftime("%d-%m-%Y"))
      expect(page).to have_content(@group.expenses.sum(:amount))
    end
  end
end
