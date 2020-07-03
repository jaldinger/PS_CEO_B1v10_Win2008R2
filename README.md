# PowerShell scripts required for installing SAP Business One version 10 components on Windows Server 2008 R2
These files should be copied to the folder `C:\Program Files\WindowsPowerShell\Modules\CEO`

Then the following should be added to `C:\Windows\System32\WindowsPowerShell\v1.0\Profile.ps1` for the module to be loaded automatically:

`Import-Module CEO`

Related blog post is over at [blogs.sap.com](https://blogs.sap.com/2020/07/03/how-to-install-sap-business-one-version-10-components-on-windows-server-2008-r2/)
