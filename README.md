# win_server_security_audit

This chef cookbook is a wrapper for an inpesc complaince profile. The inspec profile containted in this cookbook aims to measure the compliance of windows servers against security controls/policies defined in chef cookbook 'win_server_security_standards'.

These settings are recommended by various industry standards like CIS, NIST & frameworks i.e. Mitre ATT&CK

The policies are categorised in different section based on the nature of their implemtation & the OS components that they're trying to secure:
    1. Account & Password pilicies
    2. Audit Policies
    3. Logging configuration
    4. Windows Firewall policies
    5. Windows Network Security policies - Client & Server
    6. Windows Domain Memeber policies
    7. Windows UAC (User Account Policies)
    8. Windows System policies
    9. Windows Cryptographic configurations
    10. User Right Assignment policies
    11. Windows System objects policies

To use this cookbook, add the below chef recipe in you node's runlist:

    recipe[win_server_security_standards::win_server_security_policy]


This cookbook uses 2 chef reporters for collecting compliance result:
    1. json-file: this reporter outputs the result into .json file. The report file_path can be defined or controlled by node attribute or from the recipe.
    2. chef-server-automate: this reporter push the result back to chef-automate server. Find more about chef-automate integration at: https://docs.chef.io/automate/ 
