return unless Gem.win_platform?
begin
  Log.info 'Running control - 07.04'
  require 'chef/handler'
  Chef:Log.info 'Running control - 07.04'
rescue
  Log.warn 'Unable to load required libraries'
end

control '07.04' do
  title 'Ensure \'Domain member: Disable machine account password changes\' is set to \'Disabled\''
  desc 'This policy setting determines whether a domain member periodically changes its machine account password'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    its('DisablePasswordChange') { should eq 0 }
  end
end

Log.info 'Completed'
