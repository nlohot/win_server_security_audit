return unless Gem.win_platform?
begin
  Log.info 'Running control - 11.02'
  require 'chef/handler'
  Chef:Log.info 'Running control - 11.02'
rescue
  Log.warn 'Unable to load required libraries'
end

control '11.02' do
  title 'Ensure \'User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode\' is set to \'Prompt for consent on the secure desktop\''
  desc 'This policy setting controls the behavior of the elevation prompt for administrators'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    its('ConsentPromptBehaviorAdmin') { should eq 2 }
  end
end

Log.info 'Completed'
