return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.85'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.85'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.85' do
  title 'Ensure \'Require secure RPC communication\' is set to \'Enabled\''
  desc 'This policy setting allows you to specify whether Remote Desktop Services requires secure Remote Procedure Call (RPC) communication with all clients or allows unsecured communication'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    its('fEncryptRPCTraffic') { should eq 1 }
  end
end

Log.info 'Completed'
