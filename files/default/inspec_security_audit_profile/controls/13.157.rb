return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.157'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.157'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.157' do
  title 'Ensure \'Set time limit for active but idle Remote Desktop Services sessions\' is set to \'Enabled: 15 minutes or less, but not Never (0)\''
  desc 'This policy setting allows you to specify the maximum amount of time that an active Remote Desktop Services session can be idle (without user input) before it is automatically disconnected'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    its('MaxIdleTime') { should cmp 900000 }
  end
end

Log.info 'Completed'
