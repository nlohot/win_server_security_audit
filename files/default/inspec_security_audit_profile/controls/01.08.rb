return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.08'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.08'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.08' do
  title 'Ensure \'Account lockout threshold\' is set to \'5 or fewer invalid logon attempt(s), but not 0'
  desc 'This policy setting determines the number of failed logon attempts before the account is locked'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('LockoutBadCount') { should be <= 5 }
  end
  describe security_policy do
    its('LockoutBadCount') { should be > 0 }
  end
end

Log.info 'Completed'
