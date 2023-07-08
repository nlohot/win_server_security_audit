return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.07'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.07'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.07' do
  title 'Ensure \'Account lockout duration\' is set to \'15 or more minute(s)\''
  desc 'This policy setting determines the length of time that must pass before a locked account is unlocked and a user can try to log on again'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('LockoutDuration') { should be >= 15 }
  end
end

Log.info 'Completed'
