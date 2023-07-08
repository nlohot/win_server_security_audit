return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.15'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.15'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.15' do
  title 'Enable TLS v1.2'
  desc 'This policy setting allows to configure TLSv1.2 cryptographic protocol'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.2\\Client') do
    its('Enabled') { should eq 1 }
  end

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.2\\Server') do
    its('Enabled') { should eq 1 }
  end
end

Log.info 'Completed'
