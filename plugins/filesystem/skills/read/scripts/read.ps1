param(
    [Parameter(Mandatory = $true)][string]$Workspace,
    [Parameter(Mandatory = $true)][string]$Path,
    [int]$MaxBytes = 4096
)
$ErrorActionPreference = 'Stop'
if ($MaxBytes -lt 1 -or $MaxBytes -gt 4096) { throw 'MaxBytes must be from 1 through 4096' }
if ([IO.Path]::IsPathRooted($Path)) { throw 'Path must be relative to Workspace' }
$rootPath = (Resolve-Path -LiteralPath $Workspace).Path
if (-not $rootPath.EndsWith([IO.Path]::DirectorySeparatorChar)) { $rootPath += [IO.Path]::DirectorySeparatorChar }
$full = [IO.Path]::GetFullPath((Join-Path $rootPath $Path))
if (-not $full.StartsWith($rootPath, [StringComparison]::OrdinalIgnoreCase)) { throw 'Path escapes workspace' }
if (-not (Test-Path -LiteralPath $full -PathType Leaf)) { throw 'Path is not a file' }
$bytes = [IO.File]::ReadAllBytes($full)
if ($bytes.Length -gt $MaxBytes) { $bytes = $bytes[0..($MaxBytes - 1)] }
[Text.Encoding]::UTF8.GetString($bytes)
