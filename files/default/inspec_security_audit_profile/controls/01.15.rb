return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.15'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.15'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.15' do
  title 'Configure \'Accounts: Rename guest account\''
  desc '"Accounts: Rename guest account" is a security policy setting that allows you to change the name of the built-in guest account on a Windows system'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('NewGuestName') { should cmp 'NotGuest' }
  end
end

Log.info 'Completed'
