#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance
#Include, Gdip_All.ahk
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}

IniRead, LastSrc, AURA.ini, DefaultVars, LastSrc
IniRead, LastRes, AURA.ini, DefaultVars, LastRes
IniRead, LastPat, AURA.ini, DefaultVars, LastPat

Gui, Show, W480 H200, AURA image uniqualizer
Gui, Add, Edit, r1 vSrcFolderPath W400 x40 y16, Path to folder with pics to uniqalize
Gui, Add, Edit, r1 vResFolderPath W400 x40 y104, Path to put unique pics to
Gui, Add, Edit, r1 vPatFilePath W400 x40 y60, Path to uniqalisation pattern
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
guicontrol, , %a_guicontrol%, %a_guievent%
return


SrcDirSel:
{
FileSelectFolder, SrcFolder
GuiControl,, SrcFolderPath, %SrcFolder%
return
}

ResDirSel:
{
FileSelectFolder, ResFolder
GuiControl,, ResFolderPath, %ResFolder%
return
}

PatFileSel:
{
FileSelectFile, PatFile
GuiControl,, PatFilePath, %PatFile%
return
}

PicsProcess:
{
	Gui, Submit, NoHide
	GuiControl, Text, PrcButton, Please wait...


	IniWrite, %SrcFolderPath%, AURA.ini, DefaultVars, LastSrc
	IniWrite, %ResFolderPath%, AURA.ini, DefaultVars, LastRes
	IniWrite, %PatFilePath%, AURA.ini, DefaultVars, LastPat


logirovanje := FileOpen("log.txt", "w")
logirovanje.WriteLine("Let the process begin!")
		pWmark := Gdip_CreateBitmapFromFile(PatFilePath)
		wmWidth := Gdip_GetImageWidth(pWmark), wmHeight := Gdip_GetImageHeight(pWmark)


	NamesList:=[]
	FileList:=[]
	SrcF:=SrcFolderPath . "\*.jpg"

	;Getting All the files in src folder and its subfolders
	Loop, Files, %SrcF%, R
	{
		FileList.Push(A_LoopFileFullPath)
		NamesList.Push(A_LoopFileName)
		logirovanje.WriteLine(FileList[A_Index])
		logirovanje.WriteLine(NamesList[A_Index])
		logirovanje.WriteLine()
	}

	Loop % Iterations
{	

	Random, rngX, -200, 0
	Random, rngY, -200, 0

	Loop % FileList.MaxIndex()
	{
		ParentFolder := StrSplit(SrcFolderPath, "\")
		OneMoreSrc := StrReplace(SrcFolderPath, "\" . ParentFolder[ParentFolder.MaxIndex()])
		fp := StrReplace(FileList[A_Index], OneMoreSrc)
		fp := StrReplace(fp, NamesList[A_Index])
		namenoext := StrReplace(NamesList[A_Index], ".jpg")
		resDir := ResFolderPath . fp 

		if !InStr(FileExist(resdir), "D") 
		{
			FileCreateDir, %resDir%
		}

		resFile := ResFolderPath . fp . namenoext . "_" . Postfix . A_Index . ".jpg"
		CurrentFile:=FileList[A_Index]
		pBitmapF := Gdip_CreateBitmapFromFile(CurrentFile)
		Width := Gdip_GetImageWidth(pBitmapF), Height := Gdip_GetImageHeight(pBitmapF)
		pCanvas := Gdip_CreateBitmap(Width, Height)
		Graph := Gdip_GraphicsFromImage(pCanvas)

		rngXXX := rngX + (Width/2)
		rngYYY := rngY + (Height/2)
		Gdip_DrawImage(Graph, pBitmapF)
		Gdip_DrawImage(Graph, pWmark, rngXXX, rngYYY, wmWidth, wmHeight, 0, 0, Width, Height)

		Gdip_SaveBitmapToFile(pCanvas, resFile)
		logirovanje.WriteLine("Saved " . CurrentFile . " to " . resFile)
		Gdip_DisposeImage(pBitmapF)
		Gdip_DeleteGraphics(Graph)

	}
}
	Gdip_DisposeImage(pWmark)
	
	MsgBox % "Processed all " . FileList.MaxIndex() . " files and saved them to " . ResFolderPath
	GuiControl, Text, PrcButton, ALL DONE!
	return
}






GuiClose:
Gdip_Shutdown(pToken)
ExitApp
return

SrcParse(ParsArr){
	Loop, Parse, ParsArr, `n 
		{
    SrcFold := A_LoopField
    GuiControl,, SrcFolderPath, %SrcFold%
    break
		}
		return
}

ResParse(ParsArr){
	Loop, Parse, ParsArr, `n
{
    ResFold := A_LoopField
    GuiControl,, ResFolderPath, %ResFold%
    break
}
return
}

PatParse(ParsArr){
	Loop, Parse, ParsArr, `n
{
    PatFold := A_LoopField
    GuiControl,, PatFilePath, %PatFold%
    break
}
return
}
