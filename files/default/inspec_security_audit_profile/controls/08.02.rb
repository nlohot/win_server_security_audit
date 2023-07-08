return unless Gem.win_platform?
begin
  Log.info 'Running control - 08.02'
  require 'chef/handler'
  Chef:Log.info 'Running control - 08.02'
rescue
  Log.warn 'Unable to load required libraries'
end

control '08.02' do
  title 'Ensure \'Interactive logon: Do not require CTRL+ALT+DEL\' is set to \'Disabled\''
  desc 'This security setting determines whether pressing CTRL+ALT+DEL is required before a user can sign in'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    its('DisableCAD') { should eq 0 }
  end
end

Log.info 'Completed'
