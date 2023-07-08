return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.34'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.34'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.34' do
  title 'Ensure \'Replace a process level token\' is set to \'LOCAL SERVICE, NETWORK SERVICE\''
  desc 'This security setting allows one process or service to start another process or service with a different security access token'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy.SeAssignPrimaryTokenPrivilege do
    it { is_expected.to include('S-1-5-19', 'S-1-5-20')}
  end
end

Log.info 'Completed'
