return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.13'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.13'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.13' do
  title 'Configure \'Network access: Remotely accessible registry paths\' is configured'
  desc 'This policy setting determines which registry paths and subpaths are accessible when an application or process references the WinReg key to determine access permissions'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  registrypaths = [
    'System\\CurrentControlSet\\Control\\ProductOptions',
    'System\\CurrentControlSet\\Control\\Server Applications',
    'Software\\Microsoft\\Windows NT\\CurrentVersion']

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurePipeServers\\Winreg\\AllowedExactPaths') do
    its('Machine') { should be_in registrypaths }
  end
end

Log.info 'Completed'
