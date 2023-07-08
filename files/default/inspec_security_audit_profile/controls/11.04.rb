return unless Gem.win_platform?
begin
  Log.info 'Running control - 11.04'
  require 'chef/handler'
  Chef:Log.info 'Running control - 11.04'
rescue
  Log.warn 'Unable to load required libraries'
end

control '11.04' do
  title 'Ensure \'User Account Control: Detect application installations and prompt for elevation\' is set to \'Enabled\''
  desc 'This policy setting controls the behavior of application installation detection for the computer'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    its('EnableInstallerDetection') { should eq 1 }
  end
end

Log.info 'Completed'
