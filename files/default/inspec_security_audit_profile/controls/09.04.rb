return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.04'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.04'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.04' do
  title 'Ensure \'Microsoft network server: Amount of idle time required before suspending session\' is set to \'15 or fewer minute(s)\''
  desc 'This policy setting allows you to specify the amount of continuous idle time that must pass in an SMB session before the session is suspended because of inactivity'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    its('AutoDisconnect') { should eq 15 }
  end
end

Log.info 'Completed'
