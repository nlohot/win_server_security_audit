return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.35'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.35'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.35' do
  title 'Ensure \'Include command line in process creation events\' is set to \'Enabled\''
  desc 'This policy setting controls whether the process creation command line text is logged in security audit events when a new process has been created'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\Audit') do
    its('ProcessCreationIncludeCmdLine_Enabled') { should eq 1 }
  end
end

Log.info 'Completed'
