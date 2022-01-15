#Wirte process into host and add result into txt file
function Write-HostProcessResult()
{
    param
    (
        [Parameter()]
        $Status,

        [Parameter()]
        $Name,

        [Parameter()]
        $Extension,

        [Parameter()]
        $FileSize,

        [Parameter()]
        $FileCreatedDate,

        [Parameter()]
        $TodaysDate
    )

    Add-Content C:\Scripts\ErrorLog\db_backup_log_file.txt "`nFileName:$Name`nDate:$TodaysDate`nStatus:$Status"

    Write-Host $Status
    Write-Host $Name
    Write-Host $Extension 
    Write-Host $FileSize
    Write-Host $FileCreatedDate
    Write-Host $TodaysDate 
    Write-Host ""
}


#SharePoint Connection
import-Module SharePointPnPPowerShellOnline
$URL = "https://xxxx.sharepoint.com/sites/MSResearch"
Connect-PnPOnline $URL

#SharePoint list item id, name
$ID_3 = "_MS_Workflow" #1
$ID_4 = "_RS_CK" #2
$ID_5 = "_RS_EC2022"
$ID_6 = "_RS_EC_Portal"
$ID_7 = "_RS_LBR2022" #1
$ID_8 = "_RS_LBR_DTA" #2
$ID_9 = "_RS_LBR_Portal" #3
$ID_10 = "MS_RS_Library"#3
$ID_11 = "MS_Workflow" #4
$ID_12 = "NCB"#5
$ID_13 = "passwordstate" #6
$ID_14 = "RS_CK_Release" #7
$ID_15 = "RS_EC_Release"
$ID_16 = "RS_EC_DDL"
$ID_17 = "RS_EC_Portal_Release"
$ID_18 = "RS_LBR_Release" #4
$ID_19 = "RS_LBR_DTA_Release" #5
$ID_20 = "RS_LBR_Portal_Release" #6
$ID_21 = "RS_MS_TableEditorDemo" #8
$ID_22 = "_RS_N12022" #1
$ID_23 = "RS_N1_Release" #2
$ID_24 = "RS_SC_Release" #9

#File status
$fileStatus = "NA"

#Db folder path
$path = "C:\DB Backups"

#Todays date
$today = Get-Date -Format "dddd MM/dd/yyyy HH:mm"

#Write into text file
Add-Content C:\Scripts\ErrorLog\db_backup_log_file.txt "`nDateScriptStarted:$today ********************************************************"

#path directory get items
$searchResults = Get-ChildItem -Path $path | Where-Object { ((! $_.PSIsContainer))}

Write-Host "Started (>,.,<)"

#Check path directory for files lastwritetime -15 hours, and file name match.
foreach ($file in $searchResults)
{
    #Take file length and set it as gb format
    $fileSize = (($file).length/1GB)

    #Reduce decimal places to 3
    $roundFileSize = [math]::Round($fileSize,3)
            
   
    #If file is 15 hours old proceed further = FALSE
    if ($file.LastWriteTime -lt (get-date).AddHours(-15))
	{
        #Change fileStatus
        $fileStatus = "Out of Date"

        #if file file name -eq id then populate sharepoint list
	    if($file.Name.Substring(0,12) -eq $ID_3)
        {
            #Set list items by targeting list id within the sharepoint -Identity
            Set-PnPListItem -Identity 1 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"

            #Write host process results and update text file
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,6) -eq $ID_4)
        {
            Set-PnPListItem -Identity 2 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,10) -eq $ID_5)
        {
            Set-PnPListItem -Identity 5 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_6)
        {
            Set-PnPListItem -Identity 6 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,11) -eq $ID_7)
        {
            Set-PnPListItem -Identity 1 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,11) -eq $ID_8)
        {
            Set-PnPListItem -Identity 2 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,14) -eq $ID_9)
        {
            Set-PnPListItem -Identity 3 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_10)
        {
            Set-PnPListItem -Identity 3 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,11) -eq $ID_11)
        {
            Set-PnPListItem -Identity 4 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,3) -eq $ID_12)
        {
            Set-PnPListItem -Identity 5 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_13)
        {
            Set-PnPListItem -Identity 6 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_14)
        {
            Set-PnPListItem -Identity 7 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_15)
        {
            Set-PnPListItem -Identity 15 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,9) -eq $ID_16)
        {
            Set-PnPListItem -Identity 16 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,20) -eq $ID_17)
        {
            Set-PnPListItem -Identity 17 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,14) -eq $ID_18)
        {
            Set-PnPListItem -Identity 4 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,18) -eq $ID_19)
        {
            Set-PnPListItem -Identity 5 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,21) -eq $ID_20)
        {
            Set-PnPListItem -Identity 6 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,21) -eq $ID_21)
        {
            Set-PnPListItem -Identity 8 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,10) -eq $ID_22)
        {
            Set-PnPListItem -Identity 1 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Singer list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_23)
        {
            Set-PnPListItem -Identity 2 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Singer list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_24)
        {
            Set-PnPListItem -Identity 9 -Values @{"STATUS" = "FALSE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        else
        {
            $fileStatus = "File is not part of the db backup list..."
            #Add-PnPListItem -List "Others" -Values @{"Title" = $file.Name; "STATUS"="NEW FILE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm" -List "Others"}
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -FileCreatedDate $file.LastWriteTime
        }
    }
    else
    {
        #Change file status 
        $fileStatus = "SUCCESS"
	  
	    if($file.Name.Substring(0,12) -eq $ID_3)
        {
            Set-PnPListItem -Identity 1 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,6) -eq $ID_4)
        {
            Set-PnPListItem -Identity 2 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,10) -eq $ID_5)
        {
            Set-PnPListItem -Identity 5 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_6)
        {
            Set-PnPListItem -Identity 6 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,11) -eq $ID_7)
        {
            Set-PnPListItem -Identity 1 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,11) -eq $ID_8)
        {
            Set-PnPListItem -Identity 2 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,14) -eq $ID_9)
        {
            Set-PnPListItem -Identity 3 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_10)
        {
            Set-PnPListItem -Identity 3 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,11) -eq $ID_11)
        {
            Set-PnPListItem -Identity 4 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,3) -eq $ID_12)
        {
            Set-PnPListItem -Identity 5 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_13)
        {
            Set-PnPListItem -Identity 6 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_14)
        {
            Set-PnPListItem -Identity 7 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_15)
        {
            Set-PnPListItem -Identity 15 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,9) -eq $ID_16)
        {
            Set-PnPListItem -Identity 16 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,20) -eq $ID_17)
        {
            Set-PnPListItem -Identity 17 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Evercore list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,14) -eq $ID_18)
        {
            Set-PnPListItem -Identity 4 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,18) -eq $ID_19)
        {
            Set-PnPListItem -Identity 5 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,21) -eq $ID_20)
        {
            Set-PnPListItem -Identity 6 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Liberum list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,21) -eq $ID_21)
        {
            Set-PnPListItem -Identity 8 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,10) -eq $ID_22)
        {
            Set-PnPListItem -Identity 1 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Singer list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_23)
        {
            Set-PnPListItem -Identity 2 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Singer list"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,13) -eq $ID_24)
        {
            Set-PnPListItem -Identity 9 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        elseif($file.Name.Substring(0,10) -eq $ID_25)
        {
            Set-PnPListItem -Identity 10 -Values @{"STATUS" = "TRUE"; "Date" = Get-Date -Format "dddd MM/dd/yyyy HH:mm"; "FileExtension" = $file.Extension; "Size" = -Join($roundFileSize, " /GB")} -List "Others"
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -Extension $file.Extension -FileSize $roundFileSize -FileCreatedDate $file.LastWriteTime -TodaysDate $today
        }
        else
        {
            $fileStatus = "File is not part of the db backup list..."
            Write-HostProcessResult -Status $fileStatus -Name $file.Name -FileCreatedDate $file.LastWriteTime
        }
    }
}

Add-Content C:\Scripts\ErrorLog\db_backup_log_file.txt "`nDateScriptCompleted:$today ********************************************************"

#Upload file into sharepoint 
Add-PnPFile -Folder SiteAssets\DB_BACKUP_TRACKING -Path C:\Scripts\ErrorLog\db_backup_log_file.txt

Write-Host "Completed (-,.,-)"

