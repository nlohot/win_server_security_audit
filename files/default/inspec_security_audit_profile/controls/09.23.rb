return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.23'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.23'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.23' do
  title 'Ensure \'Network security: Do not store LAN Manager hash value on next password change\' is set to \'Enabled\''
  desc 'This policy setting determines whether the LAN Manager (LM) hash value for the new password is stored when the password is changed'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa') do
    its('NoLMHash') { should eq 1 }
  end
end

Log.info 'Completed'
