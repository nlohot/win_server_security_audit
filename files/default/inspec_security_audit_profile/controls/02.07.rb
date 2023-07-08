return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.07'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.07'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.07' do
  title 'Ensure \'Back up files and directories\' is set to \'Administrators\''
  desc 'This policy setting allows users to circumvent file and directory permissions to back up the system'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  sebackup = []
  sebackuptemp = security_policy.SeBackupPriviledge
  sebackup.push(sebackuptemp)

  describe.one do
    describe sebackup do
      it { is_expected.to include('S-1-5-32-544')}
    end

    describe sebackuptemp do
      it { is_expected.to include('S-1-5-32-544')}
    end
  end
end

Log.info 'Completed'
