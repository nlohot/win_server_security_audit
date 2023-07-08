return unless Gem.win_platform?
begin
  Log.info 'Running control - 06.01'
  require 'chef/handler'
  Chef:Log.info 'Running control - 06.01'
rescue
  Log.warn 'Unable to load required libraries'
end

control '06.01' do
  title 'Ensure \'Devices: Allowed to format and eject removable media\' is set to \'Administrators\''
  desc 'This policy setting determines who is allowed to format and eject removable NTFS media'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    its('AllocateDASD') { should cmp 0 }
  end
end

Log.info 'Completed'
