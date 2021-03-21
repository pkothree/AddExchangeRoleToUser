AddExchangeRoleToUser
The script will add users to an Exchange Online Role.
The users must be stored in a CSV file.

config folder
This folder includes the "config.xml" file:
EXORole: name of the EXO role
log: location of the log file
csvinput: location & name of the CSV file
delimiter: delimiter that is usedd in the CSV file
eMailField: the name of the e-Mail address field in the CSV file
givenname: the name of the given name field in the CSV file
surname: the name of the surename field in the CSV file

csvinput folder
This folder holds the CSV files (by default). It can be changed via the config file.

AddExchangeRoleToUser.ps1
Required modules: 
- AzureAD
- ExchangeOnlineManagement

Install Modules:
Install-Moddule ExchangeOnlineManagement
Install-Moddule AzureAD

1. Load the config file
2. Connect to AzureAD & Exchange Online
3. Import the CSV file
4. Iterate through each user
4.1 Check if user exists in AzureAD
4.2 If yes -> Add to Role; if no -> log an error