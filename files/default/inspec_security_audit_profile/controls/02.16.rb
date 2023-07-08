return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.16'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.16'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.16' do
  title 'Ensure \'Deny access to this computer from the network\' to include \'Guests\''
  desc 'This security setting determines which users are prevented from accessing a device over the network'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy.SeDenyNetworkLogonRight do
    it { is_expected.to include('S-1-5-32-546')}
  end
end

Log.info 'Completed'
