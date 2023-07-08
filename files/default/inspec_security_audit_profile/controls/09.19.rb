return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.19'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.19'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.19' do
  title 'Ensure \'Network security: Allow Local System to use computer identity for NTLM\' is set to \'Enabled\''
  desc 'This policy setting determines whether Local System services that use Negotiate when reverting to NTLM authentication can use the computer identity'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa') do
    its('UseMachineId') { should eq 1 }
  end
end

Log.info 'Completed'
