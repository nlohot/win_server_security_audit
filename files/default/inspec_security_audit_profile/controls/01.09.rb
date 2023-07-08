return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.09'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.09'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.09' do
  title 'Ensure \'Reset account lockout counter after\' is set to \'15 or more minute(s)'
  desc 'This policy setting determines the length of time before the Account lockout threshold resets to zero'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('ResetLockoutCount') { should be >= 15 }
  end
end

Log.info 'Completed'
