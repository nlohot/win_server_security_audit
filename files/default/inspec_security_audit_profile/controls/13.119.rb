return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.119'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.119'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.119' do
  title 'Ensure \'MSS: (KeepAliveTime) How often keep-alive packets are sent in milliseconds\' is set to \'Enabled\''
  desc 'This value controls how often TCP attempts to verify that an idle connection is still intact by sending a keep-alive packet. If the remote computer is still reachable, it acknowledges the keep-alive packet'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters') do
    its('KeepAliveTime') { should cmp 300000 }
  end
end

Log.info 'Completed'
