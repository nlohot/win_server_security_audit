return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.19'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.19'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.19' do
  title 'Ensure \'Deny log on locally\' to include \'Guests\''
  desc 'This security setting specifies the users or groups that are not allowed to log into the local computer'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy.SeDenyInteractiveLogonRight do
    it { is_expected.to include('S-1-5-32-546')}
  end
end

Log.info 'Completed'
