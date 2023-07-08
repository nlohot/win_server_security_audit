return unless Gem.win_platform?
begin
  Log.info 'Running control - 01.01'
  # require 'chef/handler'
  # Chef:Log.info 'Running control - 01.01'
rescue
  Log.warn 'Unable to load required libraries'
end

control '01.01' do
  title 'Ensure \'Enforce password history\' is set to \'24 or more password(s)\''
  desc 'Set Enforce password history to 24. This setting will help mitigate vulnerabilities that are caused by password reuse'
  impact 1.0
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe security_policy do
    its('PasswordHistorySize') { should be >= 24 }
  end
end

Log.info 'Completed'
