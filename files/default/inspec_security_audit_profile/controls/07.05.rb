return unless Gem.win_platform?
begin
  Log.info 'Running control - 07.05'
  require 'chef/handler'
  Chef:Log.info 'Running control - 07.05'
rescue
  Log.warn 'Unable to load required libraries'
end

control '07.05' do
  title 'Ensure \'Domain member: Maximum machine account password age\' is set to \'30 or fewer days, but not 0\''
  desc 'This policy setting determines when a domain member submits a password change'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    its('MaximumPasswordAge') { should eq 30 }
  end
end

Log.info 'Completed'
