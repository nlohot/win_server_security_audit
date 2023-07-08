return unless Gem.win_platform?
begin
  Log.info 'Running control - 05.06'
  require 'chef/handler'
  Chef:Log.info 'Running control - 05.06'
rescue
  Log.warn 'Unable to load required libraries'
end

control '05.06' do
  title 'Ensure \'Setup: Specify the maximum log file size (KB)\' is set to \'Enabled: 32,768 or greater\''
  desc 'The Security event log size must be configured to 32,768 KB or greater'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\EventLog\\Setup') do
    its('MaxSize') { should eq 32768 }
  end
end

Log.info 'Completed'
