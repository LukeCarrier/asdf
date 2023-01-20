function global:asdf() {
  $asdf = Get-Command -Name "asdf" -CommandType Application
  $command = $args[0]
  $commandArgs = @($asdf.Source) + $args[0 .. ($args.Count - 1)]

  $pathSep = [System.IO.Path]::PathSeparator
  $origPath = $env:PATH
  $path = [System.Collections.ArrayList]$origPath.Split($pathSep)
  $path.Remove("C:\Windows\system32")

  try {
    $env:PATH = $path -join $pathSep
    switch ($command) {
      "shell" {
        $commandArgs = @("export-shell-version", "powershell") + $commandArgs
        Start-Process -Wait -NoNewWindow -FilePath bash -ArgumentList @commandArgs | Invoke-Expression
      }
      default {
        Start-Process -Wait -NoNewWindow -FilePath bash -ArgumentList $commandArgs
      }
    }
  } finally {
    $env:PATH = $origPath
  }
}
