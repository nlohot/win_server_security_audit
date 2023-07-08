return unless Gem.win_platform?
begin
  Log.info 'Running control - 10.01'
  require 'chef/handler'
  Chef:Log.info 'Running control - 10.01'
rescue
  Log.warn 'Unable to load required libraries'
end

control '10.01' do
  title 'Ensure \'System objects: Require case insensitivity for non-Windows subsystems\' is set to \'Enabled\''
  desc 'This setting controls the behavior of non-Windows subsystems when dealing with the case of arguments or commands'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Kernel') do
    its('ObCaseInsensitive') { should eq 1 }
  end
end

Log.info 'Completed'
