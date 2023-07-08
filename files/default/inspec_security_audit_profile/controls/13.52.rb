return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.52'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.52'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.52' do
  title 'Ensure \'Configure Offer Remote Assistance\' is set to \'Disabled\''
  desc 'This policy setting allows you to turn on or turn off Offer (Unsolicited) Remote Assistance on this computer'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\OFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    its('fAllowUnsolicited') { should eq 0 }
  end
end

Log.info 'Completed'
