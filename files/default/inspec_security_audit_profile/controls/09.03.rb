return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.03'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.03'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.03' do
  title 'Ensure \'Microsoft network client: Send unencrypted password to third-party SMB servers\' is set to \'Disabled\''
  desc 'This policy setting determines whether the SMB redirector will send plaintext passwords during authentication to third-party SMB servers that do not support password encryption'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters') do
    its('EnablePlainTextPassword') { should eq 0 }
  end
end

Log.info 'Completed'
