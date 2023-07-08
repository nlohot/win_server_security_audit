return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.30'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.30'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.30' do
  title 'Ensure \'Minimize the number of simultaneous connections to the Internet or a Windows Domain\' is set to \'Enabled\''
  desc 'This policy setting prevents computers from establishing multiple simultaneous connections to either the Internet or to a Windows domain'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WcmSvc\\GroupPolicy') do
    its('fMinimizeConnections') { should eq 1 }
  end
end

Log.info 'Completed'
