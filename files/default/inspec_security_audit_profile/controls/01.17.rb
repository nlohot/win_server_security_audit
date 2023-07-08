return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.17'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.17'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.17' do
  title 'Ensure \'Network security: Force logoff when logon hours expire\' is set to \'Enabled\''
  desc 'This security setting determines whether to disconnect users who are connected to the local computer outside their user account\'s valid logon hours'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('ForceLogoffWhenHourExpire') { should eq 1 }
  end
end

Log.info 'Completed'
