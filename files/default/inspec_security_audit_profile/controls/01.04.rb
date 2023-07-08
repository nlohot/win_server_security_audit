return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.04'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.04'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.04' do
  title 'Ensure \'Minimum password length\' is set to \'14 or more character(s)'
  desc 'The Minimum password length policy setting determines the least number of characters that can make up a password for a user account'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('MinimumPasswordLength') { should be >= 14 }
  end
end

Log.info 'Completed'
