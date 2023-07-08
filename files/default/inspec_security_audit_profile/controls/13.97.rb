return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.97'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.97'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.97' do
  title 'Ensure \'Always install with elevated privileges\' is set to \'Disabled\''
  desc 'This setting controls whether or not Windows Installer should use system permissions when it installs any program on the system'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Installer') do
    its('AlwaysInstallElevated') { should eq 0 }
  end
end

Log.info 'Completed'
