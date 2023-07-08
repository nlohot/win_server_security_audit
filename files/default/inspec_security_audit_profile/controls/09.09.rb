return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.09'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.09'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.09' do
  title 'Ensure \'Network access: Do not allow anonymous enumeration of SAM accounts\' is set to \'Enabled\''
  desc 'This policy setting controls the ability of anonymous users to enumerate SAM accounts as well as shares'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa') do
    its('RestrictAnonymousSAM') { should eq 1 }
  end
end

Log.info 'Completed'
