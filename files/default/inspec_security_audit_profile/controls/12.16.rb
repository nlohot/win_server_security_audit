return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.16'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.16'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.16' do
  title 'Enable TLS v1.3'
  desc 'This policy setting allows to configure TLSv1.3 cryptographic protocol'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Client') do
    its('Enabled') { should eq 1 }
  end

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Server') do
    its('Enabled') { should eq 1 }
  end
end

Log.info 'Completed'
