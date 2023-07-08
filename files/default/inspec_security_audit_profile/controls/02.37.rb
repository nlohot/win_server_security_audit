return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.37'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.37'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.37' do
  title 'Ensure \'Take ownership of files or other objects\' is set to \'Administrators\''
  desc 'This policy setting determines which users can take ownership of any securable object in the computer, including Active Directory objects, NTFS files and folders, printers, registry keys, services, processes, and threads'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe.one do
    describe security_policy.SeTakeOwnershipPrivilege do
      it { is_expected.to include('S-1-5-32-544')}
    end

    describe security_policy.SeTakeOwnershipPrivilege do
      it { is_expected.to include('Administrators')}
    end
  end
end

Log.info 'Completed'
