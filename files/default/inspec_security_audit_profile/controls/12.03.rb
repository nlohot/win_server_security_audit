return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.03'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.03'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.03' do
  title 'Disable NULL cipher suites'
  desc 'This policy setting allows to configure NULL cipher suite'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\ciphers\\NULL') do
    its('Enabled') { should eq 0 }
  end
end

Log.info 'Completed'
