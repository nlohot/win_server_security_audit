return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.12'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.12'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.12' do
  title 'Configure \'Network access: Named Pipes that can be accessed anonymously\''
  desc 'This policy setting determines which communication sessions, or pipes, will have attributes and permissions that allow anonymous access'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  namedpipes = [
    'LSARPC',
    'NETLOGON',
    'SAMR']

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    its('NullSessionPipes') { should be_in namedpipes }
  end
end

Log.info 'Completed'
