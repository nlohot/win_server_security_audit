return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.08'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.08'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.08' do
  title 'Ensure \'Audit Logon\' is set to \'Success and Failure\''
  desc 'This subcategory reports when a user attempts to log on to the system. These events occur on the accessed computer'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('Logon') { should eq 'Success and Failure' }
  end
end

Log.info 'Completed'
