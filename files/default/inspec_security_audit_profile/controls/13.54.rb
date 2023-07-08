return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.54'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.54'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.54' do
  title 'Ensure \'Enable RPC Endpoint Mapper Client Authentication\' is set to \'Enabled\''
  desc 'This policy setting controls whether RPC clients authenticate with the Endpoint Mapper Service when the call they are making contains authentication information'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Rpc') do
    its('EnableAuthEpResolution') { should eq 1 }
  end
end

Log.info 'Completed'
