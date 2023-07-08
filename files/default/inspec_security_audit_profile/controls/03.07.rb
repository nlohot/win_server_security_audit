return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.07'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.07'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.07' do
  title 'Ensure \'Audit Logoff\' is set to include \'Success\''
  desc 'This subcategory reports when a user logs off from the system. These events occur on the accessed computer'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('Logoff') { should eq 'Success' }
  end
end

Log.info 'Completed'
