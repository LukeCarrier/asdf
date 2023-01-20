function global:asdf() {
  $asdf = Get-Command -Name "asdf" -CommandType Application
  $command = $args[0]
  $commandArgs = @($asdf.Source) + $args[0 .. ($args.Count - 1)]

  switch ($command) {
    "shell" {
      $commandArgs = @("export-shell-version", "powershell") + $commandArgs
      Start-Process -Wait -NoNewWindow -FilePath bash -ArgumentList @commandArgs | Invoke-Expression
    }
    default {
      Start-Process -Wait -NoNewWindow -FilePath bash -ArgumentList $commandArgs
    }
  }
}
