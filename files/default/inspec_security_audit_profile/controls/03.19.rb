return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.19'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.19'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.19' do
  title 'Ensure \'Audit Other Policy Change Events\' is set to include \'Failure\''
  desc 'This subcategory contains events about EFS Data Recovery Agent policy changes, changes in Windows Filtering Platform filter, status on Security policy settings updates for local Group Policy settings, Central Access Policy changes, and detailed troubleshooting events for Cryptographic Next Generation (CNG) operations'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('Other Policy Change Events') { should eq 'Failure' }
  end
end

Log.info 'Completed'
