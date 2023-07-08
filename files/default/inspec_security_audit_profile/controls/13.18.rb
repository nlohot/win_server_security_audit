return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.18'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.18'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.18' do
  title 'Ensure \'MSS: (DisableIPSourceRouting IPv6) IP source routing protection level (protects against packet spoofing)\' is set to \'Enabled: Highest protection, source routing is completely disabled\''
  desc 'IP source routing is a mechanism that allows the sender to determine the IP route that a datagram should follow through the network'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip6\\Parameters') do
    its('DisableIPSourceRouting') { should eq 2 }
  end
end

Log.info 'Completed'
