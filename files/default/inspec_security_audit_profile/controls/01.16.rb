return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.16'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.16'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.16' do
  title 'Ensure \'Network access: Allow anonymous SID/Name translation\' is set to \'Disabled\''
  desc 'This policy setting enables or disables the ability of an anonymous user to request security identifier (SID) attributes for another user'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('LSAAnonymousNameLookup') { should eq 0 }
  end
end

Log.info 'Completed'
