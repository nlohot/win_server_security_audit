return unless Gem.win_platform?
begin
  Log.info 'Running control - 10.02'
  require 'chef/handler'
  Chef:Log.info 'Running control - 10.02'
rescue
  Log.warn 'Unable to load required libraries'
end

control '10.02' do
  title 'Ensure \'System objects: Strengthen default permissions of internal system objects (e.g. Symbolic Links)\' is set to \'Enabled\''
  desc 'This security setting determines the strength of the default discretionary access control list (DACL) for objects'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager') do
    its('ProtectionMode') { should eq 1 }
  end
end

Log.info 'Completed'
