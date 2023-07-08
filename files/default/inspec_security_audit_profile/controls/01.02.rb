return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.02'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.02'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.02' do
  title 'Ensure \'Maximum password age\' is set to \'365 or fewer days, but not 0\''
  desc 'The Maximum password age policy setting determines the period of time (in days) that a password can be used before the system requires the user to change it'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('MaximumPasswordAge') { should be <= 90 }
  end
end

Log.info 'Completed'
