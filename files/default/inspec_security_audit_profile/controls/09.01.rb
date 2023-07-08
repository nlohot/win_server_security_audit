return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.01'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.01'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.01' do
  title 'Ensure \'Microsoft network client: Digitally sign communications (always)\' is set to \'Enabled\''
  desc 'This policy ensures that the SMB client will always require SMB packet signing'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters') do
    its('RequireSecuritySignature') { should eq 1 }
  end
end

Log.info 'Completed'
