return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.05'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.05'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.05' do
  title 'Ensure \'Password must meet complexity requirements\' is set to \'Enabled\''
  desc 'The Passwords must meet complexity requirements policy setting determines whether passwords must meet a series of strong-password guidelines'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('PasswordComplexity') { should eq 1 }
  end
end

Log.info 'Completed'
