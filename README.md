# HideWinUpdates v1.0
Hide Windows Updates to prevent to get them install.
The development of this script has been, in base of reversed engineering of Windows Hide and Show updates "ushowhide.diagcab".

**Use Cases:** 
EXAMPLE: 
* Get list of updates  : .\HideWinUpdates.ps1 -Action GetUpdateList
* Hide Single Update   : .\HideWinUpdates.ps1 -Action HideUpdate -IDs "XXXXXXX"
* Hide Multiple Updates: .\HideWinUpdates.ps1 -Action HideUpdate -IDs ("XXXXXXX","XXXXXXX")
