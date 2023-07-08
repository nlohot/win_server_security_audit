return unless Gem.win_platform?
begin
  Log.info 'Running control - 07.06'
  require 'chef/handler'
  Chef:Log.info 'Running control - 07.06'
rescue
  Log.warn 'Unable to load required libraries'
end

control '07.06' do
  title 'Ensure \'Domain member: Require strong (Windows 2000 or later) session key\' is set to \'Enabled\''
  desc 'This policy setting determines whether a secure channel can be established with a domain controller that isn\'t capable of encrypting secure channel traffic with a strong, 128-bit session key'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    its('RequireStrongKey') { should eq 1 }
  end
end

Log.info 'Completed'
