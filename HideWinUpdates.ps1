<#Carlos Martinez Date: 11/10/2019 GitHub @cmartinezone

DESCRIPTION:  Set Windows 10 Updates as hidden.
The script hides the Windows updates from windows updates list.

EXAMPLE: 
 Get list of updates  : .\HideWinUpdates.ps1 -Action GetUpdateList
 Hide Single Update   : .\HideWinUpdates.ps1 -Action HideUpdate -IDs "XXXXXXX"
 Hide Multiple Updates: .\HideWinUpdates.ps1 -Action HideUpdate -IDs ("XXXXXXX","XXXXXXX")
#>
Param(
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeLine = $false)]
    [ValidateSet("GetUpdateList", "HideUpdate")]
    $Action,

    [Parameter(Mandatory = $false, Position = 1, ValueFromPipeLine = $false)]
    [Object[]]$IDs
)

#Create object session for windows updates
$session = new-object -ComObject Microsoft.Update.Session
#Windows Object searcher 
$searcher = $session.CreateUpdateSearcher()
#Get List of updates not installed
$result = $searcher.Search("IsInstalled=0")

#Function to print the list of updates availble
function GetUpdateIDs {
    $result.Updates | ForEach-Object {
        Write-Host
        Write-Host "Title       : " -ForegroundColor Yellow -NoNewline ; Write-Host $_.Title 
        Write-Host "KBArticleIDs: " -ForegroundColor Yellow -NoNewline ; Write-Host $_.KBArticleIDs 
        Write-Host "IsHidden    : " -ForegroundColor Yellow -NoNewline ; Write-Host $_.IsHidden 
    }
    if ( $null -eq $result.Updates ) {
        Write-Host "No updates availble" -ForegroundColor Yellow
    }
}

#Function to Hide Updates.
function HideUpdates {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [Object[]]$UpdateIDs
    )

    #Get Update List
    $Updatelist = $result.Updates
    $LastUpdateStatus = @() #empty object to store the last status of the updates.

    $Updatelist | ForEach-Object {

        #If the Update exists on the object array of updates  and it is already hidden. 
        if ( $UpdateIDs -in $_.KBArticleIDs -and $true -eq $_.IsHidden ) {
            Write-Host    
            Write-Host "The Update is already hidden." -ForegroundColor Green                
            $LastUpdateStatus += $_ #store update status.
        }
        #If the update is exists on the object array of updates and it is not hidden.
        if ( $UpdateIDs -in $_.KBArticleIDs -and $false -eq $_.IsHidden ) {       
            try {
                #Set Update as Hidden.
                $_.IsHidden = $true  
                Write-Host
                Write-Host "The Update has been successfully hidden." -ForegroundColor Green
                $LastUpdateStatus += $_ #store update status.
        
            }
            catch {
                $error = $_.Exception.Message 
                Write-Host "FAILED:"$error -ForegroundColor Red
            }   
        }   
    }
    #Print Object of update status.
    $LastUpdateStatus | Select-Object Title, IsHidden 
}

if ($Action -eq "GetUpdateList" ) {
    GetUpdateIDs
}

if ($Action -eq "HideUpdate") {
    HideUpdates -UpdateIDs $IDs
}


