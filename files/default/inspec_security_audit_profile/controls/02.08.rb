return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.08'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.08'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.08' do
  title 'Ensure \'Change the system time\' is set to \'Administrators, LOCAL SERVICE\''
  desc 'This policy setting determines which users can adjust the time on the device\'s internal clock'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy.SeSystemTimePriviledge do
    it { is_expected.to include('S-1-5-32-544', 'S-1-5-19')}
  end
end

Log.info 'Completed'
