return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.04'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.04'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.04' do
  title 'Ensure \'Audit User Account Management\' is set to \'Success and Failure\''
  desc 'This security policy setting determines whether the operating system generates audit events when user account management tasks are performed'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('User Account Management') { should eq 'Success and Failure' }
  end
end

Log.info 'Completed'
