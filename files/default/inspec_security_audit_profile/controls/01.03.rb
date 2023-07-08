return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.03'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.03'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.03' do
  title 'Ensure \'Minimum password age\' is set to \'1 or more day(s)'
  desc 'The Minimum password age policy setting determines the period of time (in days) that a password must be used before the user can change it'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('MinimumPasswordAge') { should be >= 1 }
  end
end

Log.info 'Completed'
