return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.06'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.06'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.06' do
  title 'Ensure \'Allow log on through Remote Desktop Services\' is set to \'Administrators, Remote Desktop Users\''
  desc 'Any account with the Allow log on through Remote Desktop Services user right can log on to the remote console of the computer'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  seremot = []
  seremottemp = security_policy.SeRemoteInteractiveLogonRight
  seremot.push(seremottemp)

  describe.one do
    describe seremot do
      it { is_expected.to include('S-1-5-32-544,S-1-5-32-555')}
    end

    describe seremottemp do
      it { is_expected.to include('S-1-5-32-544', 'S-1-5-32-555')}
    end
  end
end

Log.info 'Completed'
