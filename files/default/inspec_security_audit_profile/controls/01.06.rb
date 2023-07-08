return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.06'
  require 'chef/handler'
  Chef:Log.info 'Running control - 01.06'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.06' do
  title 'Ensure \'Store passwords using reversible encryption\' is set to \'Disabled\''
  desc 'The Store password using reversible encryption policy setting provides support for applications that use protocols that require the user\'s password for authentication'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('ClearTextPassword') { should eq 0 }
  end
end

Log.info 'Completed'
