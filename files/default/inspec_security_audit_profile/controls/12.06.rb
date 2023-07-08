return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.06'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.06'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.06' do
  title 'Disable RC4 cipher suites'
  desc 'This policy setting allows to configure RC4 cipher suite'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\ciphers\\RC4 40/128') do
    its('Enabled') { should eq 0 }
  end

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\ciphers\\RC4 56/128') do
    its('Enabled') { should eq 0 }
  end

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\ciphers\\RC4 64/128') do
    its('Enabled') { should eq 0 }
  end

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\ciphers\\RC4 128/128') do
    its('Enabled') { should eq 0 }
  end
end

Log.info 'Completed'
