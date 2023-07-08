return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.76'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.76'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.76' do
  title 'Ensure \'Turn on behavior monitoring\' is set to \'Enabled\''
  desc 'This policy setting allows you to configure behavior monitoring for Windows Defender Antivirus'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Real-Time Protection') do
    its('DisableBehaviorMonitoring') { should eq 0 }
  end
end

Log.info 'Completed'
