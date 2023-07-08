# win_server_security_audit

* This chef cookbook is a wrapper for an inpesc compliance profile. The inspec profile contained in this cookbook aims to measure the compliance of Windows servers against the security controls/policies defined in the chef cookbook 'win_server_security_standards'.

These settings are recommended by various industry standards like CIS, NIST and frameworks, i.e. Mitre ATT&CK

* The policies are categorized into different sections based on the nature of their implementation and the OS components that they're trying to secure:
    1. Account and Password Policies
    2. Audit Policies
    3. Logging configuration
    4. Windows Firewall policies
    5. Windows Network Security Policies: Client and Server
    6. Windows Domain Member policies
    7. Windows UAC (User Account Policies)
    8. Windows System policies
    9. Windows Cryptographic configurations
    10. User Right Assignment policies
    11. Windows System Object policies

* To use this cookbook, add the below chef recipe to your node's runlist:

    recipe[win_server_security_audit::inspec_security_audit_profile]


* This cookbook uses two chef reporters for collecting compliance results:
    1. json-file: This reporter outputs the result into .json file. The report file_path can be defined or controlled by node attribute or from the recipe.
     2. chef-server-automate: this reporter pushes the result back to the chef-automate server. Find more about chef-automate integration at: https://docs.chef.io/automate/ 
