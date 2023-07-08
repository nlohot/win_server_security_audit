return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.28'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.28'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.28' do
  title 'Ensure \'Require domain users to elevate when setting a network\'s location\' is set to \'Enabled\''
  desc 'This policy setting determines whether to require domain users to elevate when setting a network\'s location'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Network Connections') do
    its('NC_StdDomainUserSetLocation') { should eq 0 }
  end
end

Log.info 'Completed'
