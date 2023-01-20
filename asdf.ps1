if (!(Test-Path -Path Env:\ASDF_DIR)) {
  $env:ASDF_DIR = $PSScriptRoot
}

& {
  $binDir = Join-Path $env:ASDF_DIR "bin"
  $dataDir = Join-Path $env:USERPROFILE ".asdf"
  if (Test-Path -Path Env:\ASDF_DATA_DIR) {
    $dataDir = $PSScriptRoot
  }
  $shimDir = Join-Path $dataDir "shims"

  $pathSep = [System.IO.Path]::PathSeparator
  $origPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")

  $path = $origPath.Split($pathSep)
  $binDir, $shimDir | ForEach-Object {
    if ($path -notcontains $_) {
      $path = @($_) + $path
    }
  }

  $newPath = $path -join $pathSep
  if ($newPath -ne $origPath) {
    [System.Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
  }
}

. (Join-Path (Join-Path $env:ASDF_DIR "lib") "asdf.ps1")
