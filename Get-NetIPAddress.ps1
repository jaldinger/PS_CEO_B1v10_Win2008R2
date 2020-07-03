Function Get-NetIPAddress {
    [CmdletBinding()]
    Param (
        [Parameter( Mandatory=$false )]
        [string]$AddressFamily,
        [Parameter( Mandatory=$false )]
        [string]$AddressState
    )
    Begin{}
    Process{
        $exe = 'C:\Windows\System32\ipconfig.exe';
        $result = & $exe /all

        [System.Collections.ArrayList]$connections = New-Object -TypeName System.Collections.ArrayList;
        $conn = New-Object -TypeName PSObject
        Add-Member -InputObject $conn -MemberType NoteProperty -Name InterfaceAlias -Value ""
        foreach($string in $result)
        {   
            if($string -match "^[A-Za-z0-9 *]*:$")
            {
                if($conn.InterfaceAlias -ne "") { $num = $connections.Add($conn) }
                $conn = New-Object -TypeName PSObject
                Add-Member -InputObject $conn -MemberType NoteProperty -Name InterfaceAlias `
                    -Value $string.Replace("Ethernet adapter", "").Replace("Wireless LAN adapter", "").Replace(":", "").Trim()
            }
            if($string.Trim() -match "^IPv4 Address.*")
            {
                Add-Member -InputObject $conn -MemberType NoteProperty -Name AddressFamily `
                    -Value "IPv4"
                Add-Member -InputObject $conn -MemberType NoteProperty -Name IPAddress `
                    -Value $string.Split(':')[1].Split('(')[0].Trim()
                Add-Member -InputObject $conn -MemberType NoteProperty -Name AddressState `
                    -Value "Preferred"
            }
        }
        if ($AddressFamily) { $connections = $connections.Where{ $_.AddressFamily -eq $AddressFamily } }
        if ($AddressState) { $connections = $connections.Where{ $_.AddressState -eq $AddressState } }

        $connections
    }
    End{}
}

#Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred