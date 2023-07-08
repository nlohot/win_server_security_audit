return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.05'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.05'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.05' do
  title 'Ensure \'Audit Process Creation\' is set to include \'Success\''
  desc 'This subcategory reports the creation of a process and the name of the program or user that created it'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('Process Creation') { should eq 'Success' }
  end
end

Log.info 'Completed'
