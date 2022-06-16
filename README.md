# pwsh
powershell utils

## synx
this will download synapse x for you (properly)

To run execute, run the following in cmd / powershell
```ps1
  pwsh -c "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/pozm/pwsh/master/synx.ps1" -OutFile "$env:temp/synx.ps1";&"$env:temp/synx.ps1""
```
