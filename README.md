# PowerShell scripts required for installing SAP Business One version 10 components on Windows Server 2008 R2
These files should be copied to the folder `C:\Program Files\WindowsPowerShell\Modules\CEO`

Then the following should be added to `C:\Windows\System32\WindowsPowerShell\v1.0\Profile.ps1` for the module to be loaded automatically:

`Import-Module CEO`
