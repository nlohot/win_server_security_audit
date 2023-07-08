return unless Gem.win_platform?
begin
  Log.info 'Running control - 13.84'
  require 'chef/handler'
  Chef:Log.info 'Running control - 13.84'
rescue
  Log.warn 'Unable to load required libraries'
end

control '13.84' do
  title 'Ensure \'Always prompt for password upon connection\' is set to \'Enabled\''
  desc 'This policy setting specifies whether Remote Desktop Services always prompts the client computer for a password upon connection'
  tag 'windows': %w(2012R2 2016 2019 2022)
  tag 'profile': 'Member Server'
  tag 'level': '1'

  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    its('fPromptForPassword') { should eq 1 }
  end
end

Log.info 'Completed'
