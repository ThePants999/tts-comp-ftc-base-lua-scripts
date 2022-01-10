function WriteLuaScriptToJsonContent([int]$jsonLineNumber, [int]$luaScriptFileIdx)
{
	$fileName = ('{0}{1}' -f $pathLua, $luaScriptFiles[$luaScriptFileIdx])
	$luaContent = Get-Content $fileName | Out-String | ConvertTo-Json
	
	$curJsonContentOnLine = $jsonContent[$jsonLineNumber] -replace ".{3}$"
	
	Write-Host "Writing to JSON line number $jsonLineNumber. " -NoNewLine
	$jsonContent[$jsonLineNumber] = $curJsonContentOnLine + $luaContent + ","
}

$pathLua = '..\TTSLUA\'
$luaScriptFiles = @('global.ttslua')
$luaScriptFiles += Get-ChildItem $pathLua -include *.ttslua -exclude global.ttslua -name
 
$pathJson = '..\TTSJSON\'
$jsonName = 'ftc_base'
$jsonExt = '.json'
$jsonCompileUpdate = '_compiled'

$regexLuaGUID = '-- FTC-GUID: (.*)'
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
$version = Read-Host "Version number"
if($version -ne "")
{
	if($version.substring(0,1) -ne "v")
	{
		$version = "v" + $version
	}
}

$luaContent = ''
$luaGUID = @()
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
	
	# grab the contents of the lua script file and capture the GUID from the first line
	Write-Host "Searching for GUID in $fileName... " -NoNewLine
	$luaContent = Get-Content $fileName
	$luaGUID += $luaContent[0] | Select-String $regexLuaGUID
	# test to see if we received a valid GUID
	if($luaGUID[$luaIdx - 1] -eq 0)
	{
		Write-Host "No GUID found! Ending compilation..."
		Pause
		exit
	}

	if($luaGUID.Matches[$luaIdx - 1].Groups[1].Value -eq "")
	{
		Write-Host "No GUID found! Ending compilation..."
		Pause
		exit
	}
	
	$guidStr = $luaGUID.Matches[$luaIdx - 1].Groups[1].Value
	Write-Host "GUID $guidStr found."
}

# grab the contents of the json file
$fileName = $pathJson + $jsonName + $jsonExt
Write-Host "Searching for GUIDs in $fileName... " -NoNewLine
$jsonContent = Get-Content $fileName
$lineNum = 0
$jsonGUID = ''

# find each line that contains a GUID and LuaScript in the json file
# there will be one more LuaScript line than GUID as this is the global LuaScript
$jsonGUIDLine      = $jsonContent | Select-String $regexJsonGUID
$jsonLuaScriptLine = $jsonContent | Select-String $regexJsonLuaScript
Write-Host $jsonGUIDLine.Count "GUIDs found."

# update the json content with the global LuaScript content
$lineNum = $jsonLuaScriptLine[0].LineNumber - 1
Write-Host 'Locating Global LuaScript in JSON... ' -NoNewLine
WriteLuaScriptToJsonContent $lineNum 0
Write-Host 'Successful update.'

# iterate through the lua script GUIDs
for($idx = 0; $idx -lt $luaGUID.Count; $idx++)
{
	$num = $idx + 1
	if($num -lt 10) { $num = "0$num" }
	$numOf = $luaGUID.Count
	$findGUID = $luaGUID.Matches[$idx].Groups[1].Value
	Write-Host "Locating GUID $findGUID $num out of $numOf... " -NoNewLine
	
	$GUIDfound = 'False'
	# check against the list of GUIDs from the json file
	for($jsonGUIDIdx = 0; $jsonGUIDIdx -lt $jsonGUIDLine.Count; $jsonGUIDIdx++)
	{
		$jsonGUID = $jsonGUIDLine.Matches[$jsonGUIDIdx].Groups[1].Value
		# match the json GUID with the lua script GUID then modify json content 
		if($findGUID -eq $jsonGUID)
		{
			$lineNum = $jsonLuaScriptLine[$jsonGUIDIdx + 1].LineNumber - 1
			Write-Host 'GUID found! ' -NoNewLine
			WriteLuaScriptToJsonContent $lineNum ($idx + 1)
			$GUIDfound = 'True'
			Write-Host 'Successful update!'
			$jsonGUIDIdx = $jsonGUIDLine.Count
		}
	}
	
	# stop if no GUID match was found
	if($GUIDfound -eq 'False')
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
	$jsonContent[1] = $jsonLine + ' - ' + $version + '\n",'
	Write-Host "Writing to GameMode... " -NoNewLine
	$jsonLine = $jsonContent[2] -replace ".{4}$"
	$jsonContent[2] = $jsonLine + ' - ' + $version + '\n",'
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
Pause
