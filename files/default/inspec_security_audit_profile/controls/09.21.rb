return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.21'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.21'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.21' do
  title 'Ensure \'Network Security: Allow PKU2U authentication requests to this computer to use online identities\' is set to \'Disabled\''
  desc 'This setting determines if online identities are able to authenticate to this computer'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa\\pku2u') do
    its('AllowOnlineID') { should eq 0 }
  end
end

Log.info 'Completed'
