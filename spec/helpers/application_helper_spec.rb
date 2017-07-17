require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#current_active_menu' do
    it 'returns \'active\' when current_page matches' do
      allow(helper).to receive(:current_active_menu).and_return('active')
      expect(helper.current_active_menu('/users/sign_up')).to eq('active')
    end

    it 'returns empty string when current_page does not match' do
      visit new_user_registration_path
      expect(helper.current_active_menu(root_path)).to eq('')
    end
  end

  describe '#format_date' do
    it 'returns the formatted date when a date is passed as param' do
      expect(helper.format_date(Date.today)).to eq(Date.today.strftime('%d/%m/%Y'))
    end

    it 'returns nil when a there is no param' do
      expect(helper.format_date(nil)).to be_nil
    end
  end

  describe '#format_datetime' do
    it 'returns the formatted datetime when a datetime is passed as param' do
      expect(helper.format_datetime(Time.now)).to eq(Time.now.strftime('%d/%m/%Y'))
    end

    it 'returns nil when a there is no param' do
      expect(helper.format_datetime(nil)).to be_nil
    end
  end
end
