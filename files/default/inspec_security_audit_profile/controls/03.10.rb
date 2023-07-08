return unless Gem.win_platform?
begin
  Log.info 'Running control - 03.10'
  require 'chef/handler'
  Chef:Log.info 'Running control - 03.10'
rescue
  Log.warn 'Unable to load required libraries'
end

control '03.10' do
  title 'Ensure \'Audit Special Logon\' is set to include \'Success\''
  desc 'This subcategory records special logons which have administrative privileges and can be used to elevate processes'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe audit_policy do
    its('Special Logon') { should eq 'Success' }
  end
end

Log.info 'Completed'
