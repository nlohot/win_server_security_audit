return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.24'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.24'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.24' do
  title 'Ensure \'Impersonate a client after authentication\' is set to \'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE\''
  desc 'This security setting specifies the users or groups that are allowed to impersonate a client after authentication'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  seimpersonate = []
  seimpersonatetemp = security_policy.SeImpersonatePriviledge
  seimpersonate.push(seimpersonate)

  describe.one do
    describe seimpersonate do
      it { is_expected.to include('S-1-5-32-544', 'S-1-5-19', 'S-1-5-20', 'S-1-5-6')}
    end

    describe seimpersonatetemp do
      it { is_expected.to include('S-1-5-32-544', 'S-1-5-19', 'S-1-5-20', 'S-1-5-6')}
    end
  end
end

Log.info 'Completed'
