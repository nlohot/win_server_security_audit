return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.36'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.36'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.36' do
  title 'Ensure \'Encryption Oracle Remediation\' is set to \'Enabled: Force Updated Clients\''
  desc 'Some versions of the CredSSP protocol that is used by some applications (such as Remote Desktop Connection) are vulnerable to an encryption oracle attack against the client'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\CredSSP\\Parameters') do
    its('AllowEncryptionOracle') { should eq 0 }
  end
end

Log.info 'Completed'
