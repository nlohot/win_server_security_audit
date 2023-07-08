return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.01'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.01'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.01' do
  title 'Ensure \'Audit Credential Validation\' is set to \'Success and Failure\''
  desc 'This subcategory reports the results of validation tests on credentials submitted for a user account logon request'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('Credential Validation') { should eq 'Success and Failure' }
  end
end

Log.info 'Completed'
