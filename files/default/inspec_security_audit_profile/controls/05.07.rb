return unless Gem.win_platform?
begin
  Log.info 'Running control - 05.07'
  require 'chef/handler'
  Chef:Log.info 'Running control - 05.07'
rescue
  Log.warn 'Unable to load required libraries'
end

control '05.07' do
  title 'Ensure \'System: Control Event Log behavior when the log file reaches its maximum size\' is set to \'Disabled\''
  desc 'This policy setting controls Event Log behavior when the log file reaches its maximum size'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\EventLog\\System') do
    its('Retention') { should cmp 0 }
  end
end

Log.info 'Completed'
