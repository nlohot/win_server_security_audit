return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.18'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.18'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.18' do
  title 'Ensure \'Audit MPSSVC Rule-Level Policy Change\' is set to \'Success and Failure\''
  desc 'This subcategory determines whether the operating system generates audit events when changes are made to policy rules for the Microsoft Protection Service (MPSSVC.exe)'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('MPSSVC Rule-Level Policy Change') { should eq 'Success and Failure' }
  end
end

Log.info 'Completed'
