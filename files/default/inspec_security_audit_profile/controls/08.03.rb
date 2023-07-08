return unless Gem.win_platform?
begin
  Log.info 'Running control - 08.03'
  require 'chef/handler'
  Chef:Log.info 'Running control - 08.03'
rescue
  Log.warn 'Unable to load required libraries'
end

control '08.03' do
  title 'Ensure \'Interactive logon: Machine inactivity limit\' is set to \'900 or fewer second(s), but not 0\''
  desc 'Machine inactivity limit is a security policy setting that locks a device based on the duration of user-input inactivity'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    its('InactivityTimeoutSecs') { should eq 900 }
  end
end

Log.info 'Completed'
