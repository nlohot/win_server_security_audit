return unless Gem.win_platform?
begin
  Log.info 'Running control - 04.09'
  require 'chef/handler'
  Chef:Log.info 'Running control - 04.09'
rescue
  Log.warn 'Unable to load required libraries'
end

control '04.09' do
  title 'Ensure \'Windows Firewall: Private: Firewall state\' is set to \'On\''
  desc 'Specifies whether Windows Firewall with Advanced Security uses the settings for the Private profile to filter network traffic'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile') do
    its('EnableFirewall') { should eq 1 }
  end
end

Log.info 'Completed'
