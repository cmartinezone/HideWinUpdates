# HideWinUpdates v1.0
Hide Windows Updates to prevent to get them install. The development of this script has been based in reversed engineering of Windows “Show or Hide Updates” [wushowhide.diagcab](https://support.microsoft.com/en-us/help/3073930/how-to-temporarily-prevent-a-driver-update-from-reinstalling-in-window) and translated to a PowerShell manageable syntax.

## Use Cases:
```
* Get list of updates  : .\HideWinUpdates.ps1 -Action GetUpdateList
* Hide Single Update   : .\HideWinUpdates.ps1 -Action HideUpdate -IDs "XXXXXXX"
* Hide Multiple Updates: .\HideWinUpdates.ps1 -Action HideUpdate -IDs ("XXXXXXX","XXXXXXX")
```

## Donation:
If this script help you to complete any task, you can give me a cup of coffee :)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.me/cmartinezone)
