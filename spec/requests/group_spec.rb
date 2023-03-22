require 'rails_helper'

RSpec.describe 'Groups page', type: :system do
  describe 'Groups /index' do
    before(:each) do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @icon_file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png')
      @group = Group.create(name: 'food', icon: @icon_file, user: @user)
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

    it 'displays the name, date, icon, amount of group' do
      expect(page).to have_content(@group.name)
      expect(page).to have_content(@group.created_at.strftime("%d-%m-%Y"))
      expect(page).to have_content(@group.expenses.sum(:amount))
    end

    it 'click on category' do
      link = find('a', text: @group.name, match: :first)
      link.click
      sleep(1)
      expect(page).to have_current_path group_path(@group)
    end

    it 'click on add new category button' do
      link = find('a', text: 'Add new category', match: :first)
      link.click
      sleep(1)
      expect(page).to have_current_path new_group_path
    end
  end
end
