return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.14'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.14'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.14' do
  title 'Enable Triple DES cipher suites'
  desc 'This policy setting allows to configure Triple DES cipher suites'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Ciphers\\Triple DES 168') do
    its('Enabled') { should cmp 4294967295  }
  end
end

Log.info 'Completed'
