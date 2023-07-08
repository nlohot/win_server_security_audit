return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.06'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.06'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.06' do
  title 'Ensure \'Microsoft network server: Digitally sign communications (if client agrees)\' is set to \'Enabled\''
  desc 'This policy setting determines whether the SMB server will negotiate SMB packet signing with clients that request it'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    its('EnableSecuritySignature') { should eq 1 }
  end
end

Log.info 'Completed'
