return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.11'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.11'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.11' do
  title 'Ensure \'Configure SMB v1 client driver\' is set to \'Enabled: Disable driver (recommended)\''
  desc 'This setting configures the start type for the Server Message Block version 1 (SMBv1) client driver service (MRxSmb10), which is recommended to be disabled'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\mrxsmb10') do
    its('Start') { should eq 0 }
  end
end

Log.info 'Completed'
