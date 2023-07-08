return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.02'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.02'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.02' do
  title 'Ensure \'Audit Application Group Management\' is set to \'Success and Failure\''
  desc 'This security policy setting determines whether the operating system generates audit events when application group management tasks are performed'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('Application Group Management') { should eq 'Success and Failure' }
  end
end

Log.info 'Completed'
