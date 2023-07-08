return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.26'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.26'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.26' do
  title 'Ensure \'Turn off multicast name resolution\' is set to \'Enabled\''
  desc 'LLMNR is a secondary name resolution protocol. With LLMNR, queries are sent using multicast over a local network link on a single subnet from a client computer to another client computer on the same subnet that also has LLMNR enabled'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\DNSClient') do
    its('EnableMulticast') { should eq 0 }
  end
end

Log.info 'Completed'
