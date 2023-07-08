return unless Gem.win_platform?
begin
  Log.info 'Running control - 11.03'
  require 'chef/handler'
  Chef:Log.info 'Running control - 11.03'
rescue
  Log.warn 'Unable to load required libraries'
end

control '11.03' do
  title 'Ensure \'User Account Control: Behavior of the elevation prompt for standard users\' is set to \'Automatically deny elevation requests\''
  desc 'This policy setting controls the behavior of the elevation prompt for standard users'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    its('ConsentPromptBehaviorUser') { should eq 0 }
  end
end

Log.info 'Completed'
