return unless Gem.win_platform?
begin
  Log.info 'Running control - 08.06'
  require 'chef/handler'
  Chef:Log.info 'Running control - 08.06'
rescue
  Log.warn 'Unable to load required libraries'
end

control '08.06' do
  title 'Ensure \'Interactive logon: Prompt user to change password before expiration\' is set to \'between 5 and 14 days\''
  desc 'This policy setting determines when users are warned that their passwords are about to expire'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    its('PasswordExpiryWarning') { should cmp 14 }
  end
end

Log.info 'Completed'
