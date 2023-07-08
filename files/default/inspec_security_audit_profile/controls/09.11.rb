return unless Gem.win_platform?
begin
  Log.info 'Running control - 09.11'
  require 'chef/handler'
  Chef:Log.info 'Running control - 09.11'
rescue
  Log.warn 'Unable to load required libraries'
end

control '09.11' do
  title 'Ensure \'Network access: Let Everyone permissions apply to anonymous users\' is set to \'Disabled\''
  desc 'This security setting determines what additional permissions are granted for anonymous connections to the computer'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa') do
    its('EveryoneIncludesAnonymous') { should eq 0 }
  end
end

Log.info 'Completed'
