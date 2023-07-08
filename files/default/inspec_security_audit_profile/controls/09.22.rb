return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.22'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.22'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.22' do
  title 'Ensure \'Network security: Configure encryption types allowed for Kerberos\' is set to \'AES128_HMAC_SHA1, AES256_HMAC_SHA1, Future encryption types\''
  desc 'This policy setting allows you to set the encryption types that Kerberos is allowed to use'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\Kerberos\\Parameters') do
    its('SupportedEncryptionTypes') { should cmp 2147483640 }
  end
end

Log.info 'Completed'
