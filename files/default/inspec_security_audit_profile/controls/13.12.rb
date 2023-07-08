return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.12'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.12'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.12' do
  title 'Ensure \'Configure SMB v1 server\' is set to \'Disabled\''
  desc 'This setting configures the server-side processing of the Server Message Block version 1 (SMBv1) protocol'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanServer\\Parameters') do
    its('SMB1') { should eq 0 }
  end
end

Log.info 'Completed'
