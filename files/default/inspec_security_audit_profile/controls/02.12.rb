return unless Gem.win_platform?
begin
  Log.info 'Running control - 02.12'
  require 'chef/handler'
  Chef:Log.info 'Running control - 02.12'
rescue
  Log.warn 'Unable to load required libraries'
end

control '02.12' do
  title 'Ensure \'Create global objects\' is set to \'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE\''
  desc 'This policy setting determines whether users can create global objects that are available to all sessions'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  seglobal = []
  seglobaltemp = security_policy.SeCreateGlobalPrivilege
  seglobal.push(seglobaltemp)

  script = <<-URA
    Import-Module C:\\temp\\UserRights.psm1
    $rights = (Get-AccountsWithUserRight -Right SeCreateGlobalPrivilege).SID
    $rights
  URA

  describe.one do
    describe seglobal do
      it { is_expected.to include('S-1-5-32-544', 'S-1-5-19', 'S-1-5-20', 'S-1-5-6')}
    end

    describe seglobaltemp do
      it { is_expected.to include('S-1-5-32-544', 'S-1-5-19', 'S-1-5-20', 'S-1-5-6')}
    end

    describe powershell(script) do
      its('stdout') { should include 'S-1-5-32-544' }
      its('stdout') { should include 'S-1-5-19' }
      its('stdout') { should include 'S-1-5-20' }
      its('stdout') { should include 'S-1-5-6' }
    end
  end
end

Log.info 'Completed'
