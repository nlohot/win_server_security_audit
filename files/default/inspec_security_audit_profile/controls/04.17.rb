return unless Gem.win_platform?
begin
  Log.info 'Running control - 04.17'
  require 'chef/handler'
  Chef:Log.info 'Running control - 04.17'
rescue
  Log.warn 'Unable to load required libraries'
end

control '04.17' do
  title 'Ensure \'Windows Firewall: Public: Firewall state\' is set to \'On\''
  desc 'Specifies whether Windows Firewall with Advanced Security uses the settings for the Public profile to filter network traffic'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PublicProfile') do
    its('EnableFirewall') { should eq 1 }
  end
end

Log.info 'Completed'
