Function Get-NetTCPConnection {
    [CmdletBinding()]
    Param ()
    Begin{}
    Process{
        $exe = 'C:\Windows\System32\netstat.exe';
        $result = & $exe -ano

        [System.Collections.ArrayList]$ports = New-Object -TypeName System.Collections.ArrayList;
        $port = New-Object -TypeName PSObject
        Add-Member -InputObject $port -MemberType NoteProperty -Name LocalPort -Value 0
        foreach($string in $result)
        {   
            
            $cols = $string -split '\s+' | Where {$_}
            if($cols.Count -eq 5 -and $cols[0] -eq "TCP" -and $cols[1] -notmatch '^\[')
            {
                #"***** LINE:" + $string
                $port= New-Object -TypeName PSObject
                Add-Member -InputObject $port -MemberType NoteProperty -Name LocalAddress -Value $cols[1].Split(':')[0]
                Add-Member -InputObject $port -MemberType NoteProperty -Name LocalPort -Value $cols[1].Split(':')[1]
                Add-Member -InputObject $port -MemberType NoteProperty -Name RemoteAddress -Value $cols[2].Split(':')[0]
                Add-Member -InputObject $port -MemberType NoteProperty -Name RemotePort -Value $cols[2].Split(':')[1]
                $num = $ports.Add($port)
            }
        }
        $ports
    }
    End{}
}

#Get-NetTCPConnection |  Where-Object { $_.LocalPort -eq 55365 }