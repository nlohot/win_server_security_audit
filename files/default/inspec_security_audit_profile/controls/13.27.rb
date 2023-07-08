return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.27'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.27'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.27' do
  title 'Ensure \'Prohibit installation and configuration of Network Bridge on your DNS domain network\' is set to \'Enabled\''
  desc 'The Network Bridge setting, if enabled, allows users to create a Layer 2 Media Access Control (MAC) bridge, enabling them to connect two or more physical network segments together'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Network Connections') do
    its('NC_AllowNetBridge_NLA') { should eq 0 }
  end
end

Log.info 'Completed'
