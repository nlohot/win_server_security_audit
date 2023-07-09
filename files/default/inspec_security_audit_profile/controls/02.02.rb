return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.02'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.02'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.02' do
  title 'Ensure \'Access this computer from the network\'  is set to \'Administrators, Authenticated Users\''
  desc 'This policy setting determines policy setting determines which users can connect to the device from the network'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy.SeNetworkLogonRight do
    it { should include 'S-1-5-32-544' }
    it { should include 'S-1-5-11' }
  end
end

Log.info 'Completed'
