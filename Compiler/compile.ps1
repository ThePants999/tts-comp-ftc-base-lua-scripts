param ([Switch]$test)

function WriteLuaScriptToJsonContent([int]$jsonLineNumber, [int]$luaScriptFileIdx)
{
	$fileName = ('{0}{1}' -f $pathLua, $luaScriptFiles[$luaScriptFileIdx])
	$luaContent = Get-Content $fileName | Out-String | ConvertTo-Json

	$curJsonContentOnLine = $jsonContent[$jsonLineNumber] -replace ".{3}$"

	Write-Host "Writing to JSON line number $jsonLineNumber. " -NoNewLine
	$jsonContent[$jsonLineNumber] = $curJsonContentOnLine + $luaContent + ","
}

# Update this if TTS is installed elsewhere.
$ttsSaves = "$([Environment]::GetFolderPath('MyDocuments'))\My Games\Tabletop Simulator\Saves\"

$pathLua = '..\TTSLUA\'
$luaScriptFiles = @('global.ttslua')
$luaScriptFiles += Get-ChildItem $pathLua -include *.ttslua -exclude global.ttslua -name

$pathJson = '..\TTSJSON\'
$jsonName = 'ftc_base'
$jsonExt = '.json'
$jsonCompileUpdate = '_compiled'

$regexLuaGUID = '(?<=-- FTC-GUID:.*)([0-9a-f]{6})'
$regexJsonGUID = '"GUID": "(.*)"'
$regexJsonLuaScript = '"LuaScript": '

# test to see if the json file exists
$fileName = $pathJson + $jsonName + $jsonExt
if(!(Test-Path $fileName))
{
	Write-Host "$fileName could not be found! Ending compilation..."
}

# ask user to give a version number
# blank input gives no version
if ($test -eq $false)
{
	$version = Read-Host "Version number"
	if($version -ne "")
	{
		if($version.substring(0,1) -ne "v")
		{
			$version = "v" + $version
		}
	}
}
else
{
	$version = "test"
}

$luaContent = ''
$luaGUIDs = @()
# pull each of the GUIDs and store them, ignore the first lua file as it's the global file with no GUID
for($luaIdx = 1; $luaIdx -lt $luaScriptFiles.Count; $luaIdx++)
{
	# test if the lua script file does exists
	$fileName = ('{0}{1}' -f $pathLua, $luaScriptFiles[$luaIdx])
	if(!(Test-Path $fileName))
	{
		Write-Host "$fileName could not be found! Ending compilation..."
		Pause
		exit
	}

	# grab the contents of the lua script file and capture the GUIDs from the first line
	Write-Host "Searching for GUIDs in $fileName... " -NoNewLine
	$luaContent = Get-Content $fileName
	$results = $luaContent[0] | Select-String -AllMatches -Pattern $regexLuaGUID

	# test to see if we received valid GUIDs
	if($results.Matches.Length -eq 0)
	{
		Write-Host "No GUIDs found! Ending compilation..."
		Pause
		exit
	}

	Write-Host "GUIDs " -NoNewLine
	foreach($match in $results.Matches)
	{
		# For each found GUID, store the combo of that GUID and the current file
		# index. (The comma in the append operation ensures we append an array,
		# rather than unrolling it and appending the contents.)
		$guid = $match.Value
		$luaGUIDs += , @($guid, $luaIdx)
		Write-Host "$guid " -NoNewLine
	}
	Write-Host "found."
}

# grab the contents of the json file
$fileName = $pathJson + $jsonName + $jsonExt
Write-Host "Searching for GUIDs in $fileName... " -NoNewLine
$jsonContent = Get-Content $fileName
$lineNum = 0
$jsonGUID = ''

# find each line that contains a GUID and LuaScript in the json file
# there will be one more LuaScript line than GUID as this is the global LuaScript
#
# ThePants999 note: this ^ is rubbish. There are loads of objects with no LuaScript line,
# so the number of GUID lines is way higher than the number of LuaScript lines. I CBA to
# sort this out properly, so I've just moved the "infinite bag" objects which are the
# primary culprits to the end of the file. If you find that the compiler is determining
# -1 as the line number for the LuaScript, then you need to either fix this or move the
# corresponding object earlier in the file.
$jsonGUIDLine      = $jsonContent | Select-String $regexJsonGUID
$jsonLuaScriptLine = $jsonContent | Select-String $regexJsonLuaScript
Write-Host $jsonGUIDLine.Count "GUIDs found."

# update the json content with the global LuaScript content
$lineNum = $jsonLuaScriptLine[0].LineNumber - 1
Write-Host 'Locating Global LuaScript in JSON... ' -NoNewLine
WriteLuaScriptToJsonContent $lineNum 0
Write-Host 'Successful update.'

# iterate through the lua script GUIDs
foreach($guid in $luaGUIDs)
{
	$findGUID = $guid[0]
	$fileIndex = $guid[1]
	$fileName = $luaScriptFiles[$fileIndex]
	Write-Host "Locating GUID $findGUID for $fileName... " -NoNewLine

	$GUIDfound = $false
	# check against the list of GUIDs from the json file
	for($jsonGUIDIdx = 0; $jsonGUIDIdx -lt $jsonGUIDLine.Count; $jsonGUIDIdx++)
	{
		$jsonGUID = $jsonGUIDLine.Matches[$jsonGUIDIdx].Groups[1].Value
		# match the json GUID with the lua script GUID then modify json content
		if($findGUID -eq $jsonGUID)
		{
			$lineNum = $jsonLuaScriptLine[$jsonGUIDIdx + 1].LineNumber - 1
			Write-Host 'GUID found! ' -NoNewLine
			WriteLuaScriptToJsonContent $lineNum $fileIndex
			$GUIDfound = $true
			Write-Host 'Successful update!'
			$jsonGUIDIdx = $jsonGUIDLine.Count
		}
	}

	# stop if no GUID match was found
	if(!($GUIDfound))
	{
		Write-Host 'GUID not found! Ending compilation...'
		Pause
		exit
	}
}

# write version number
if($version -ne "")
{
	Write-Host "Writing to SaveName... " -NoNewLine
	$jsonLine = $jsonContent[1] -replace ".{4}$"
	$jsonContent[1] = $jsonLine + ' - ' + $version + '",'
	Write-Host "Writing to GameMode... " -NoNewLine
	$jsonLine = $jsonContent[2] -replace ".{4}$"
	$jsonContent[2] = $jsonLine + ' - ' + $version + '",'
	Write-Host "Done."
}

# write out the content to a new file
if($version -ne "")
{
	$fileName = ".\" + $jsonName + "_" + $version + $jsonCompileUpdate + $jsonExt
}
else
{
	$fileName = ".\" + $jsonName + $jsonCompileUpdate + $jsonExt
}

$jsonContent | Set-Content $fileName
Write-Host "File $fileName complete."

if ($test -ne $null)
{
	Copy-Item $fileName -Destination $ttsSaves
	Write-Host "Copied to $ttsSaves."
}