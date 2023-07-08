return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.158'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.158'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.158' do
  title 'Ensure \'Set time limit for disconnected sessions\' is set to \'Enabled: 1 minute\''
  desc 'This policy setting allows you to configure a time limit for disconnected Remote Desktop Services sessions'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    its('MaxDisconnectionTime') { should cmp 60000 }
  end
end

Log.info 'Completed'
