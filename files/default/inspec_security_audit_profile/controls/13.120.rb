return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.120'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.120'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.120' do
  title 'Ensure \'MSS: (PerformRouterDiscovery) Allow IRDP to detect and configure Default Gateway addresses (could lead to DoS)\' is set to \'Disabled\''
  desc 'This setting is used to enable or disable the Internet Router Discovery Protocol (IRDP), which allows the system to detect and configure default gateway addresses automatically as described in RFC 1256 on a per-interface basis'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters') do
    its('PerformRouterDiscovery') { should eq 0 }
  end
end

Log.info 'Completed'
