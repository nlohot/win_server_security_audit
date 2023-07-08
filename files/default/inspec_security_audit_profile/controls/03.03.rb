return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.03'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.03'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.03' do
  title 'Ensure \'Audit Security Group Management\' is set to include \'Success\''
  desc 'This security policy setting determines whether the operating system generates audit events when security group management tasks are performed'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('Security Group Management') { should eq 'Success' }
  end
end

Log.info 'Completed'
