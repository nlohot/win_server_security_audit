return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.12'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.12'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.12' do
  title 'Disable TLS v1.1'
  desc 'This policy setting allows to configure TLSv1.1 cryptographic protocol'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.1\\Client') do
    its('Enabled') { should eq 0 }
  end

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.1\\Server') do
    its('Enabled') { should eq 0 }
  end
end

Log.info 'Completed'
