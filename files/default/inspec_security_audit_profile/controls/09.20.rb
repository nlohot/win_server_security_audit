return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.20'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.20'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.20' do
  title 'Ensure \'Network security: Allow LocalSystem NULL session fallback\' is set to \'Disabled\''
  desc 'This policy setting determines whether NTLM is allowed to fall back to a NULL session when used with LocalSystem'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa\\MSV1_0') do
    its('AllowNullSessionFallback') { should eq 1 }
  end
end

Log.info 'Completed'
