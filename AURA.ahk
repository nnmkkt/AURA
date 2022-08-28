#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Ignore
#Include, Gdip_All.ahk
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global WM_USER               := 0x00000400
global PBM_SETMARQUEE        := WM_USER + 10
global PBM_SETSTATE          := WM_USER + 16
global PBS_MARQUEE           := 0x00000008
global PBS_SMOOTH            := 0x00000001
global PBS_VERTICAL          := 0x00000004
global PBST_NORMAL           := 0x00000001
global PBST_ERROR            := 0x00000002
global PBST_PAUSE            := 0x00000003
global STAP_ALLOW_NONCLIENT  := 0x00000001
global STAP_ALLOW_CONTROLS   := 0x00000002
global STAP_ALLOW_WEBCONTENT := 0x00000004
global WM_THEMECHANGED       := 0x0000031A

If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}

IniRead, LastSrc1, AURA.ini, Dropdown, LastSrc1
IniRead, LastSrc2, AURA.ini, Dropdown, LastSrc2
IniRead, LastSrc3, AURA.ini, Dropdown, LastSrc3
IniRead, LastSrc4, AURA.ini, Dropdown, LastSrc4
IniRead, LastSrc5, AURA.ini, Dropdown, LastSrc5

IniRead, LastRes1, AURA.ini, Dropdown, LastRes1
IniRead, LastRes2, AURA.ini, Dropdown, LastRes2
IniRead, LastRes3, AURA.ini, Dropdown, LastRes3
IniRead, LastRes4, AURA.ini, Dropdown, LastRes4
IniRead, LastRes5, AURA.ini, Dropdown, LastRes5

IniRead, LastPat1, AURA.ini, Dropdown, LastPat1
IniRead, LastPat2, AURA.ini, Dropdown, LastPat2
IniRead, LastPat3, AURA.ini, Dropdown, LastPat3
IniRead, LastPat4, AURA.ini, Dropdown, LastPat4
IniRead, LastPat5, AURA.ini, Dropdown, LastPat5

Gui, Show, W480 H200, AURA image uniqalizer
Gui, Add, ComboBox, r5 vSrcFolderPath W400 x40 y16, %LastSrc1%||%LastSrc2%|%LastSrc3%|%LastSrc4%|%LastSrc5%
Gui, Add, ComboBox, r5 vResFolderPath W400 x40 y104, %LastRes1%||%LastRes2%|%LastRes3%|%LastRes4%|%LastRes5%
Gui, Add, ComboBox, r5 vPatFilePath W400 x40 y60, %LastPat1%||%LastPat2%|%LastPat3%|%LastPat4%|%LastPat5%
Gui, Add, Button, x440 y16 w17 h17 vSrcButton gSrcDirSel, ...
Gui, Add, Button, x440 y60 w17 h17 vPatButton gPatFileSel, ...
Gui, Add, Button, x440 y104 w17 h17 vResButton gResDirSel, ...
Gui, Add, Edit, r1 vPostfix x150 w100, Filename postfix
Gui, Add, Edit, r1 vIterations x250 y131 w100, Number of iterations
Gui, Add, UpDown, vMyUpDown, 5
Gui, Add, Button, x100 w300 h30 Center vPrcButton gPicsProcess, PROCESS IT ALREADY!!1!
GuiControl,, SrcFolderPath, %LastSrc%
GuiControl,, ResFolderPath, %LastRes%
GuiControl,, PatFilePath, %LastPat%
return



;GuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y) {
;		FileValue := FileArray[1]
;		GuiControl,, CtrlHwnd
;		return
;}

GuiDropFiles:
guicontrol, Text, %a_guicontrol%, %a_guievent%
return


SrcDirSel:
{
FileSelectFolder, SrcFolder
GuiControl, Text, SrcFolderPath, %SrcFolder%
return
}

ResDirSel:
{
FileSelectFolder, ResFolder
GuiControl, Text, ResFolderPath, %ResFolder%
return
}

PatFileSel:
{
FileSelectFile, PatFile
GuiControl, Text, PatFilePath, %PatFile%
return
}

PicsProcess:
{
	Gui, Submit, NoHide
	    ;this is dumb af, but i couldnt figure out anything better
        SrcF:=SrcFolderPath . "\*.jpg"
Loop, Files, %SrcF%, R
        {
        FileCount++
        }
        
    progress := FileCount * Iterations
    ControlGetPos, prcposx, prcposy, prcw, prch, Button4
    prcposy -= 10
    GuiControl, Hide, PrcButton
    GuiControlGet, progressexist, HWND, Progressbar
    if (progressexist=""){
        Gui, Add, Progress, X100 Y%prcposy% w300 h20 Range0-%progress% vProgressbar hwndPROG -%PBS_SMOOTH%, 0
        DllCall("User32.dll\SendMessage", "Ptr", PROG, "Int", PBM_SETSTATE, "Ptr", PBST_NORMAL, "Ptr", 0)
} else{
GuiControl,,Progressbar,0
GuiControl, Show, Progressbar
}
    IniWrite, %LastSrc4%, AURA.ini, Dropdown, LastSrc5
    IniWrite, %LastSrc3%, AURA.ini, Dropdown, LastSrc4
    IniWrite, %LastSrc2%, AURA.ini, Dropdown, LastSrc3
    IniWrite, %LastSrc1%, AURA.ini, Dropdown, LastSrc2
    IniWrite, %SrcFolderPath%, AURA.ini, Dropdown, LastSrc1
    
    IniWrite, %LastRes4%, AURA.ini, Dropdown, LastRes5
    IniWrite, %LastRes3%, AURA.ini, Dropdown, LastRes4
    IniWrite, %LastRes2%, AURA.ini, Dropdown, LastRes3
    IniWrite, %LastRes1%, AURA.ini, Dropdown, LastRes2
    IniWrite, %ResFolderPath%, AURA.ini, Dropdown, LastRes1
    
    IniWrite, %LastPat4%, AURA.ini, Dropdown, LastPat5
    IniWrite, %LastPat3%, AURA.ini, Dropdown, LastPat4
    IniWrite, %LastPat2%, AURA.ini, Dropdown, LastPat3
    IniWrite, %LastPat1%, AURA.ini, Dropdown, LastPat2
    IniWrite, %PatFilePath%, AURA.ini, Dropdown, LastPat1
    
    
		pWmark := Gdip_CreateBitmapFromFile(PatFilePath)
		wmWidth := Gdip_GetImageWidth(pWmark), wmHeight := Gdip_GetImageHeight(pWmark)


	
	
    

	;Getting All the files in src folder and its subfolders
	Loop, Files, %SrcF%, R
	{
		FileList := A_LoopFileFullPath
		NamesList := A_LoopFileName
	Loop % Iterations
{	
	Random, rngX, -200, 0
	Random, rngY, -200, 0

	
		ParentFolder := StrSplit(SrcFolderPath, "\")
		OneMoreSrc := StrReplace(SrcFolderPath, "\" . ParentFolder[ParentFolder.MaxIndex()])
		fp := StrReplace(FileList, OneMoreSrc)
		fp := StrReplace(fp, NamesList)
		namenoext := StrReplace(NamesList, ".jpg")
		resDir := ResFolderPath . fp 

		if !InStr(FileExist(resdir), "D") 
		{
			FileCreateDir, %resDir%
		}

		resFile := ResFolderPath . fp . namenoext . "_" . Postfix . A_Index . ".jpg"
		CurrentFile:=FileList
		pBitmapF := Gdip_CreateBitmapFromFile(CurrentFile)
		Width := Gdip_GetImageWidth(pBitmapF), Height := Gdip_GetImageHeight(pBitmapF)
		pCanvas := Gdip_CreateBitmap(Width, Height)
		Graph := Gdip_GraphicsFromImage(pCanvas)

		rngXXX := rngX + (Width/2)
		rngYYY := rngY + (Height/2)
		Gdip_DrawImage(Graph, pBitmapF)
		Gdip_DrawImage(Graph, pWmark, rngXXX, rngYYY, wmWidth, wmHeight, 0, 0, Width, Height)

		Gdip_SaveBitmapToFile(pCanvas, resFile)
		Gdip_DisposeImage(pBitmapF)
        Gdip_DisposeImage(pCanvas)
		Gdip_DeleteGraphics(Graph)
        GuiControl,, progressbar, +1

}

}
Gdip_DisposeImage(pWmark)
    
	MsgBox % "Processed all " . FileCount . " files and saved them to " . ResFolderPath
	GuiControl, Hide, progressbar
	GuiControl, Show, PrcButton
	return
}



GuiClose:
Gdip_Shutdown(pToken)
ExitApp
return

