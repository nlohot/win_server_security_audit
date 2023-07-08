return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.17'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.17'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.17' do
  title 'Ensure \'MSS: (AutoAdminLogon) Enable Automatic Logon (not recommended)\' is set to \'Disabled\''
  desc 'This setting is separate from the Welcome screen feature in Windows XP and Windows Vista; if that feature is disabled, this setting is not disabled'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    its('AutoAdminLogon') { should eq 0 }
  end
end

Log.info 'Completed'
