return unless Gem.win_platform?
begin
  Log.info 'Running control - 04.01'
  require 'chef/handler'
  Chef:Log.info 'Running control - 04.01'
rescue
  Log.warn 'Unable to load required libraries'
end

control '04.01' do
  title 'Ensure \'Windows Firewall: Domain: Firewall state\' is set to \'On\''
  desc 'This check enables the firewall when connected to the domain'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile') do
    its('EnableFirewall') { should eq 1 }
  end
end

Log.info 'Completed'
