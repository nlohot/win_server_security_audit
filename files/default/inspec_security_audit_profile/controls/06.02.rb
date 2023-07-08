return unless Gem.win_platform?
begin
  Log.info 'Running control - 06.02'
  require 'chef/handler'
  Chef:Log.info 'Running control - 06.02'
rescue
  Log.warn 'Unable to load required libraries'
end

control '06.02' do
  title 'Ensure \'Devices: Prevent users from installing printer drivers\' is set to \'Enabled\''
  desc 'This policy setting determines who can install a printer driver as part of adding a network printer'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Print\\Providers\\LanMan Print Services\\Servers') do
    its('AddPrinterDrivers') { should eq 1 }
  end
end

Log.info 'Completed'
