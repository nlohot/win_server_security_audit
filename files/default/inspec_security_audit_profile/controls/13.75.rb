return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.75'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.75'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.75' do
  title 'Ensure \'Turn off real-time protection\' is set to \'Disabled\''
  desc 'This policy setting configures real-time protection prompts for known malware detection'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Real-Time Protection') do
    its('DisableRealtimeMonitoring') { should eq 0 }
  end
end

Log.info 'Completed'
