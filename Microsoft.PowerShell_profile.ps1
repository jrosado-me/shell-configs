# $PROFILE.CurrentUserAllHosts

function global:env( $v )           { gci env:$v | sort Name }
function global:smite( $v )         { rd -Force -Recurse $v }
function global:func_ls( $v )       { gci -Force -Name $v | sort Name }
function global:func_ll()           { gci -Force }  
function global:func_cd( $v )       { $old = "$PWD"; Set-Location $v; if ($?) { si env:OLDPWD "$old" } }
function global:func_funcdef( $v )  { (gcm $v).definition }
function global:func_edit( $v )     { notepad $v }
function global:func_touch( $v )
{
    if ($v -eq $null) { throw "No filename supplied" }
    if (Test-Path $v) { (Get-ChildItem $v).LastWriteTime = Get-Date } else { echo $null > $v }
}
function global:cd-()               { func_cd("$env:OLDPWD") }
function global:editprofile()       { ise $PROFILE.CurrentUserAllHosts }

sal ll    func_ll       -Force -Option AllScope -Scope Global
sal ls    func_ls       -Force -Option AllScope -Scope Global
sal cd    func_cd       -Force -Option AllScope -Scope Global
sal func  func_funcdef  -Force -Option AllScope -Scope Global
sal edit  func_edit     -Force -Option AllScope -Scope Global

$MaximumHistoryCount = 4096

si env:gitRoot 0x00
function global:prompt()
{
    Write-Host "$env:username@$env:computername" -NoNewline -ForegroundColor Green
    Write-Host " ($PWD)" -NoNewline -ForegroundColor Blue
  
    # NOTE: If necessary, start storing all git root directories in a semi-colon delimited env variable
    # TODO: Support submodules. Currently breaks prompt
    $dir = "$PWD";
    if (Test-Path("$dir\.git"))
    {
        si env:gitRoot "$dir";
    }

    if ("$dir".Contains($env:gitRoot))
    {
        $branch = gc "$env:gitRoot\.git\HEAD";
        Write-Host " [$($branch.Substring(16))]" -NoNewline -ForegroundColor Magenta
    }
  
    Write-Host "`nPS> " -NoNewline -ForegroundColor White
  
    return " ";
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
