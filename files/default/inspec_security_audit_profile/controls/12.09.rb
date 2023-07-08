return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.09'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.09'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.09' do
  title 'Disable SSL v2.0'
  desc 'This policy setting allows to configure SSLv2 cryptographic protocol'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\SSL 2.0\\Client') do
    its('Enabled') { should eq 0 }
  end

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\SSL 2.0\\Server') do
    its('Enabled') { should eq 0 }
  end
end

Log.info 'Completed'
