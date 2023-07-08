return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.13'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.13'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.13' do
  title 'Enable AES cipher suites'
  desc 'This policy setting allows to configure AES cipher suites'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Ciphers\\AES 128/128') do
    its('Enabled') { should cmp 4294967295  }
  end

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Ciphers\\AES 256/256') do
    its('Enabled') { should cmp 4294967295  }
  end
end

Log.info 'Completed'
