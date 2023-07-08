return unless Gem.win_platform?
begin
  Log.info 'Running control - 04.10'
  require 'chef/handler'
  Chef:Log.info 'Running control - 04.10'
rescue
  Log.warn 'Unable to load required libraries'
end

control '04.10' do
  title 'Ensure \'Windows Firewall: Private: Inbound connections\' is set to \'Block\''
  desc 'This setting determines the behavior for inbound connections that do not match an inbound firewall rule'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile') do
    its('DefaultInboundAction') { should eq 0 }
  end
end

Log.info 'Completed'
