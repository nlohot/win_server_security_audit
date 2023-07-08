return unless Gem.win_platform?
begin
  Log.info 'Running control - 12.08'
  require 'chef/handler'
  Chef:Log.info 'Running control - 12.08'
rescue
  Log.warn 'Unable to load required libraries'
end

control '12.08' do
  title 'Disable SHA1 Hashing Algorithm'
  desc 'This policy setting allows to configure SHA1 Hashing Algorithm'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Hashes\\SHA') do
    its('Enabled') { should eq 0 }
  end
end

Log.info 'Completed'
