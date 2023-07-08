return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.15'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.15'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.15' do
  title 'Ensure \'NetBT NodeType configuration\' is set to \'Enabled: P-node (recommended)\''
  desc 'This setting determines which method NetBIOS over TCP/IP (NetBT) uses to register and resolve names'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NetBT\\Parameters') do
    its('NodeType') { should eq 2 }
  end
end

Log.info 'Completed'
