return unless Gem.win_platform?
begin
  Log.info 'Running control - 11.05'
  require 'chef/handler'
  Chef:Log.info 'Running control - 11.05'
rescue
  Log.warn 'Unable to load required libraries'
end

control '11.05' do
  title 'Ensure \'User Account Control: Only elevate UIAccess applications that are installed in secure locations\' is set to \'Enabled\''
  desc 'This setting allows programs installed in a secured location only to run with elevated privileges'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    its('EnableSecureUIAPaths') { should eq 1 }
  end
end

Log.info 'Completed'
