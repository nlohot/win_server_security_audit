return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.04'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.04'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.04' do
  title 'Disable DES cipher suites'
  desc 'This policy setting allows to configure DES cipher suite'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\ciphers\\DES 56/56') do
    its('Enabled') { should eq 0 }
  end
end

Log.info 'Completed'
