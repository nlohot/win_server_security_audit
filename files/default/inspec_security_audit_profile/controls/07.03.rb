return unless Gem.win_platform?
begin
  Log.info 'Running control - 07.03'
  require 'chef/handler'
  Chef:Log.info 'Running control - 07.03'
rescue
  Log.warn 'Unable to load required libraries'
end

control '07.03' do
  title 'Ensure \'Domain member: Digitally sign secure channel data (when possible)\' is set to \'Enabled\''
  desc 'This setting determines whether all secure channel traffic that is initiated by the domain member meets minimum security requirements'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    its('SignSecureChannel') { should eq 1 }
  end
end

Log.info 'Completed'
