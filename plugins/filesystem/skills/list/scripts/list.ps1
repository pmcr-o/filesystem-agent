param(
    [Parameter(Mandatory = $true)][string]$Workspace,
    [Parameter(Mandatory = $true)][string]$Path
)
$ErrorActionPreference = 'Stop'
if ([IO.Path]::IsPathRooted($Path)) { throw 'Path must be relative to Workspace' }
$rootPath = (Resolve-Path -LiteralPath $Workspace).Path
if (-not $rootPath.EndsWith([IO.Path]::DirectorySeparatorChar)) { $rootPath += [IO.Path]::DirectorySeparatorChar }
$full = [IO.Path]::GetFullPath((Join-Path $rootPath $Path))
if (-not $full.StartsWith($rootPath, [StringComparison]::OrdinalIgnoreCase)) { throw 'Path escapes workspace' }
if (-not (Test-Path -LiteralPath $full -PathType Container)) { throw 'Path is not a directory' }
Get-ChildItem -LiteralPath $full | ForEach-Object { $_.Name }
