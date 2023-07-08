# Skipping if tagged
if run_context.node['tags'].include?('skip_audit')
  Chef::Log.info('Skipping windows server security audit on this node')
  return
end

node.default['audit']['report_path'] = 'c:\\chef\\cache\\inspec.json'
node.default['audit']['reporter'] = %w{json-file chef-server-automate}
node.default['audit']['profiles']['base/inspec_security_audit_profile'] = {
  'path' => 'c:/chef/cache/cookbooks/win_server_security_audit/files/default/inspec_security_audit_profile'
}

load_audit_handler
