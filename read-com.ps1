function read-com {
    $Host.ui.rawui.backgroundcolor = "Black"
    Clear-Host

    function Select-By-Index {
        #Default is 0
        param (
            [string]$message,
            [string[]]$options
        )
        Write-Host $message -ForegroundColor Green
        for ($i = 0; $i -lt $options.Count; $i++) {
            $opt = $options[$i]
            Write-Host "[$i] `t|`t$opt" -ForegroundColor Yellow
        }
        do {
            Write-Host "Select $message " -NoNewline -ForegroundColor Green
            $selectedIndex = Read-Host
            if (!$selectedIndex) { $selectedIndex = 0 }
        } while ($selectedIndex -lt 0 -or $selectedIndex -ge $options.Count)
        return $selectedIndex
    }

    function Format-Input {
        param([string]$message)
        return $message.ToCharArray() | ForEach-Object { "{0:X2}" -f [System.Convert]::ToUInt32($_) }
    }

    $Ports = [System.IO.Ports.SerialPort]::getportnames()
    $PortIndex = $null

    $BaudRates = @(115200, 9600, 19200, 38400, 57600, 4800, 14400, 2400, 230400)
    $BaudRatesIndex = $null

    $ParityBits = @("None", "Odd", "Even", "Mark", "Space")
    $ParityBitsIndex = $null

    $DataBits = @(8, 5, 6, 7)
    $DataBitsIndex = $null

    $StopBits = @("One", "Two", "OnePointFive")
    $StopBitsIndex = $null

    $OutputFormats = @("ASCII", "HEX")
    $OutputFormatsIndex = $null

    if ($Ports) {
        $PortIndex = Select-By-Index -message "Port" -options $Ports
        Clear-Host

        $BaudRatesIndex = Select-By-Index -message "Baud Rate" -options $BaudRates
        Clear-Host

        $ParityBitsIndex = Select-By-Index -message "Parity Bits" -options $ParityBits
        Clear-Host

        $DataBitsIndex = Select-By-Index -message "Data Bits" -options $DataBits
        Clear-Host

        $StopBitsIndex = Select-By-Index -message "Stop Bits" -options $StopBits
        Clear-Host

        $OutputFormatsIndex = Select-By-Index -message "Output Format" -options $OutputFormats
        Clear-Host

        try {
            $Port = new-Object System.IO.Ports.SerialPort $Ports[$PortIndex], $BaudRates[$BaudRatesIndex], $ParityBits[$ParityBitsIndex], $DataBits[$DataBitsIndex], $StopBits[$StopBitsIndex]
            $Port.Open()
            Write-Host "Port configured successfully." -ForegroundColor Green
            Write-Host "$($Ports[$PortIndex], $BaudRates[$BaudRatesIndex], $ParityBits[$ParityBitsIndex], $DataBits[$DataBitsIndex], $StopBits[$StopBitsIndex],$OutputFormats[$OutputFormatsIndex])" -ForegroundColor Green

            do {
                $when = Get-Date -UFormat "[%d/%m | %T] "
                $line = $Port.ReadLine()
                Write-Host "$($when)" -ForegroundColor DarkCyan -NoNewLine
                switch ($OutputFormats[$OutputFormatsIndex]) {
                    "HEX" {
                        Write-Host $(Format-Input -message $line) -ForegroundColor Magenta
                    }
                    Default {
                        Write-Host "$($line)" -ForegroundColor DarkYellow
                    }
                }
            } while ($Port.IsOpen)
        }
        catch [UnauthorizedAccessException] { 
            Write-Host "Access denied. The Port $($Ports[$PortIndex]) may be in use." -ForegroundColor Red
        }
        finally {
            $Port.Close()
        }
    }
    else {
        Write-Host "------------ No COMS available ------------" -ForegroundColor Red
    }
}

read-com
