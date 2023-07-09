return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.12'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.12'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.12' do
  title 'Ensure \'Accounts: Guest account status\' is set to \'Disabled\''
  desc 'The Accounts: Guest account status policy setting determines whether the Guest account is enabled or disabled'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('EnableGuestAccount') { should cmp 0 }
  end
end

Log.info 'Completed'
