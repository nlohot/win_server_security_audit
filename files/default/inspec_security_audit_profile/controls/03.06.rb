return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.06'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.06'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.06' do
  title 'Ensure \'Audit Account Lockout\' is set to include \'Failure\''
  desc 'This subcategory reports when a user\'s account is locked out as a result of too many failed logon attempts'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('Account Lockout') { should eq 'Failure' }
  end
end

Log.info 'Completed'
