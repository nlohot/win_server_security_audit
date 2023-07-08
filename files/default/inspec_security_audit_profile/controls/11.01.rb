return unless Gem.win_platform?
begin
  Log.info 'Running control - 11.01'
  require 'chef/handler'
  Chef:Log.info 'Running control - 11.01'
rescue
  Log.warn 'Unable to load required libraries'
end

control '11.01' do
  title 'Ensure \'User Account Control: Admin Approval Mode for the Built-in Administrator account\' is set to \'Enabled\''
  desc 'This policy setting controls the behavior of Admin Approval Mode for the built-in Administrator account'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    its('FilterAdministratorToken') { should eq 1 }
  end
end

Log.info 'Completed'
