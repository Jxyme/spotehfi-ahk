/* ; ---------------------------------------------------
SET #DIRECTIVES
*/ ; ---------------------------------------------------

#NoEnv
#SingleInstance Force
SendMode, Input
SetWorkingDir, %A_ScriptDir%
DetectHiddenWindows, On
SetTitleMatchMode, 2
SetBatchLines, -1

/* ; ---------------------------------------------------
Preload
*/ ; ---------------------------------------------------

global bgColour := ""
global accentColour := ""

ValidateFiles()
SettingsIni()

/* ; ---------------------------------------------------
GLOBAL VARIABLES
*/ ; --------------------------------------------------- 

global SubDir := "%(title)s.%(ext)s"
global Version = "v0.0.1.0"

/* ; ---------------------------------------------------
BUILD MAIN GUI
*/ ; ---------------------------------------------------

Menu, Tray, Icon, resources/assets/spotify.ico,, 1

Menu, Tray, Add, Restore, Restore
Menu, Tray, Default, Restore
Menu, Tray, Click, 2

btnSettings = resources/assets/btnSettings.png
btnShare = resources/assets/btnShare.png
btnSpotify = resources/assets/btnSpotify.png
btnDownload = resources/assets/btnDownload.png
btnYouTube = resources/assets/btnYouTube.png

Gui -MaximizeBox
Gui Color, %bgColour%
Gui Font, s10 w1000 q5 c%accentColour%, Circular Std Book
Gui Add, Text, hwndhNpText x8 y8 w105 h25 +0x200 +Left, NOW PLAYING
Gui Font, s20 Bold q5 cWhite, Circular Std Book
Gui Add, Text, vSongName x8 y37 w550 h35 +0x4000 
Gui Font, s10 w1000 q5 c%accentColour%, Circular Std Book
Gui Add, Text, hwndhByText x8 y74 w17 h35 +0x200 , By
Gui Font, s10 Bold q5 cWhite, Circular Std Book
Gui Add, Text, vSongArtist x31 y74 w600 h35 +0x200 
Gui Add, Picture, hwndhSettings gSettings x562 y8, %btnSettings%
Gui Add, Picture, hwndhShare gShare x160 y121, %btnShare%
Gui Add, Picture, hwndhSpotify gSpotify x8 y121, %btnSpotify%
Gui Add, Picture, hwndhDownload gYouTubeDownload x367 y121, %btnDownload%
Gui Add, Picture, hwndhYouTube gYouTubeSearch x214 y121, %btnYouTube%
Gui Font, s10 w1000 q5 cWhite, Circular Std Book
Gui Show, w600 h165, Spotehfi %Version%

OnMessage(0x200, "WM_MOUSEMOVE")

SetTimer, NowPlaying

/* ; ---------------------------------------------------
STATIC TOOLTIPS
*/ ; ---------------------------------------------------

AddToolTip(hSettings, "User Settings")
AddToolTip(hShare, "Copy Spotify URI for Now Playing")
AddToolTip(hSpotify, "Browse Spotify for Now Playing")
AddToolTip(hDownload, "Download Now Playing from YouTube")
AddToolTip(hYouTube, "Browse YouTube for Now Playing")
return

/* ; ---------------------------------------------------
BUILD SETTINGS GUI
*/ ; ---------------------------------------------------

Settings(){

   global Background := bgColour
   global Accent := accentColour
   global Output := pathSetting

   global hUpdateA,hUpdateB,hUpdateC,hResetA,hResetB,hResetC  ; Hand Cursor (Settings GUI)

   btnUpdate = resources/assets/btnUpdate.png
   btnReset = resources/assets/btnReset.png

   WinGetPos, X, Y,, Spotehfi ; position Settings GUI slightly underneath Main GUI
   Y := Y + 10
   X := X + 10
   
   IniRead, bgColour, settings.ini, Palette, backgroundCol
   IniRead, accentColour, settings.ini, Palette, accentCol
   IniRead, pathSetting, settings.ini, Directory, downloadPath

   Gui, 1: Show, w600 h165, Spotehfi %Version% - Inactive (Colour Preview)
   Gui, 1: Submit, NoHide

   Gui, Submit, NoHide
   Gui, 2: Color, %bgColour%
   Gui, 2: Add, Edit, y500 +ReadOnly ; simple fix for deselecting Background EditTextBox
   Gui, 2: Font, s10 w1000 q5 c%accentColour%, Circular Std Book
   Gui, 2: Add, Text, hwndhUserSettings x8 y8 w125 h25 +0x200 +Left, USER SETTINGS
   Gui, 2: Font, s20 Bold q5 cWhite, Circular Std Book
   Gui, 2: Add, Text, x8 y40 +0x200, Primary (Background)
   Gui, 2: Font, s20 Bold q5 c%accentColour%, Circular Std Book
   Gui, 2: Add, Edit, vBackground w205 x300 y37 +Center, %bgColour%
   Gui, 2: Add, Picture, gBackgroundUpdate hwndhUpdateB x520 y42, %btnUpdate%
   Gui, 2: Add, Picture, gBackgroundReset hwndhResetB x562 y42, %btnReset%
   Gui, 2: Font, s20 Bold q5 cWhite, Circular Std Book
   Gui, 2: Add, Text, x8 y103 +0x200, Secondary (Accent)
   Gui, 2: Font, s20 Bold q5 c%accentColour%, Circular Std Book
   Gui, 2: Add, Edit, vAccent w205 x300 y100 +Center, %accentColour%
   Gui, 2: Add, Picture, gAccentUpdate hwndhUpdateA x520 y105, %btnUpdate%
   Gui, 2: Add, Picture, gAccentReset hwndhResetA x562 y105, %btnReset%
   Gui, 2: Font, s20 Bold q5 cWhite, Circular Std Book
   Gui, 2: Add, Text, x8 y167 +0x200, Output
   Gui, 2: Font, s20 Bold q5 c%accentColour%, Circular Std Book
   Gui, 2: Add, Edit, vOutput w380 x125 y163 +Center +ReadOnly, %pathSetting%
   Gui, 2: Add, Picture, gOutputUpdate hwndhUpdateC x520 y169, %btnUpdate%
   Gui, 2: Add, Picture, gOutputReset hwndhResetC x562 y169, %btnReset%

   Gui, 2: Show, w600 h225 x%X% y%Y%, Spotehfi %Version% - User Settings

   Gui, 1: +Disabled

   OnMessage(0x200, "WM_MOUSEMOVE")

   AddToolTip(hUpdateC, "Edit")
   AddToolTip(hResetC, "Revert to Default")
   AddToolTip(hUpdateB, "Update")
   AddToolTip(hResetB, "Revert to Default")
   AddToolTip(hUpdateA, "Update")
   AddToolTip(hResetA, "Revert to Default")
   return
}

BackgroundUpdate:
   Gui, Submit, NoHide
   setBgCol := Background
   IniWrite, %setBgCol%, settings.ini, Palette, backgroundCol
   Gui, 1: Color, %setBgCol%
   Gui, 2: Color, %setBgCol%
   GuiControl, 2:, Background, %setBgCol%
return

AccentUpdate:
   Gui, Submit, NoHide
   setAccentCol := Accent
   IniWrite, %setAccentCol%, settings.ini, Palette, accentCol
   ; Font at s10 (Size 10) - Now Playing & User Settings
   Gui, 1: Font, c%setAccentCol% q5 s10
   ; Now Playing
   GuiControl, 1: Font, % hNpText
   ; User Settings
   GuiControl, 1: Font, % hByText
   ; Font at s10 (Size 10) - User Settings (GUI 2)
   Gui, 2: Font, c%setAccentCol% q5 s10
   ; By
   GuiControl, 2: Font, % hUserSettings
   ; Font at s20 (Size 20) - Background
   Gui, 2: Font, c%setAccentCol% q5 s20
   ; Background Text (GUI 2)
   GuiControl, 2: Font, % Background
   ; Accent Text (GUI 2)
   GuiControl, 2: Font, % Accent
   ; Output Text (GUI 2)
   GuiControl, 2: Font, % Output
return

OutputUpdate:
   Gui, Submit, NoHide
   IniRead, pathSetting, settings.ini, Directory, downloadPath
   FileSelectFolder, CustomDir, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 3
   If (CustomDir = "") {
      dirInQuotes := "Default"
      IniWrite, %dirInQuotes%, settings.ini, Directory, downloadPath
      GuiControl, 2: Text, Output, % dirInQuotes
   } Else
      dirInQuotes := CustomDir
      IniWrite, %dirInQuotes%, settings.ini, Directory, downloadPath
      GuiControl, 2: Text, Output, % dirInQuotes
return

BackgroundReset:
   Gui, Submit, NoHide
   resetBgCol := "2B3544"
   IniWrite, %resetBgCol%, settings.ini, Palette, backgroundCol
   Gui, 1: Color, %resetBgCol%
   Gui, 2: Color, %resetBgCol%
   GuiControl, 2:, Background, %resetBgCol%
return

AccentReset:
   Gui, Submit, NoHide
   resetAccentCol := "FFC621"
   IniWrite, %resetAccentCol%, settings.ini, Palette, accentCol
   ; Font at s10 (Size 10) - Now Playing & User Settings
   Gui, 1: Font, c%resetAccentCol% q5 s10
   ; Now Playing
   GuiControl, 1: Font, % hNpText
   ; User Settings
   GuiControl, 1: Font, % hByText
   ; Font at s10 (Size 10) - User Settings (GUI 2)
   Gui, 2: Font, c%resetAccentCol% q5 s10
   ; By
   GuiControl, 2: Font, % hUserSettings
   ; Font at s20 (Size 20) - Background
   Gui, 2: Font, c%resetAccentCol% q5 s20
   ; Background Text (GUI 2)
   GuiControl, 2: Font, % Background
   ; Accent Text (GUI 2)
   GuiControl, 2: Font, % Accent
   ; Reset Accent Text to Default (GUI 2)
   GuiControl, 2: Text, Accent, % resetAccentCol
   ; Reset Output Text to Default (GUI 2)
   GuiControl, 2: Font, % Output
return

OutputReset:
   Gui, Submit, NoHide
   dirInQuotes := "Default"
   IniWrite, %dirInQuotes%, settings.ini, Directory, downloadPath
   GuiControl, 2: Text, Output, % dirInQuotes
return

NowPlaying(){
   WinGetTitle, np, - ahk_exe Spotify.exe ahk_class Chrome_WidgetWin_0
   np := StrReplace(np, "&", "&&")
   stripHyphen := StrReplace(" - ", "")
   song := SubStr(np, InStr(np, stripHyphen) +3)
   artist := SubStr(np, 1, InStr(np, stripHyphen) -1)
   song_f := RegExReplace(song, "\([^)]*\)", "")
   GuiControlGet, SongName
   GuiControl,, SongName, %song_f%
   GuiControlGet, SongArtist
   GuiControl,, SongArtist, %artist%
   Global nowPlaying := stripHyphen
}

Spotify(){
   WinGetTitle, np, - ahk_exe Spotify.exe ahk_class Chrome_WidgetWin_0
   If (np == "") {
      return
   }else  {
      np := StrReplace("spotify:search:"np, " ", "+")
      Run, %np%
   } return
}

YouTubeSearch(){
   WinGetTitle, np, - ahk_exe Spotify.exe ahk_class Chrome_WidgetWin_0
   If (np == ""){
      return
   }else{
      url := InitQuery(np)
      Run, %url%
   } return
}

YouTubeDownload(){
   WinGetTitle, np, - ahk_exe Spotify.exe ahk_class Chrome_WidgetWin_0
   If (np == ""){
      return
   }else{
      url := InitQuery(np)
      CustomDir(url)
   } return
}

InitQuery(onNow){ ; onNow = spotify search uri
   query := StrReplace("https://www.youtube.com/results?search_query="onNow, " ", "+")
   stripAmpersand := StrReplace(query, "&", "%26")
   r := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   r.Open("GET", stripAmpersand, false)
   r.Send()
   r.WaitForResponse()
   If (RegExMatch(r.ResponseText, "/watch\?v=.{11}", exact)) {
   url := "https://www.youtube.com" exact
   } 
   return url
}

CustomDir(url){ ; url == youtube url to dl
   IniRead, pathSetting, settings.ini, Directory, downloadPath
   If (pathSetting = "Default") {
      RunWait, %ComSpec% /c "resources\tools\youtube-dl.exe -x --audio-format mp3 --audio-quality 0 %url% -o "%A_ScriptDir%\downloads\%SubDir%""
   } Else {
      RunWait, %ComSpec% /c "resources\tools\youtube-dl.exe -x --audio-format mp3 --audio-quality 0 %url% -o "%pathSetting%\%SubDir%""
   } 
   return
}

ConstructToSearch(strIn){ ; strIn = constructURI
   constructURI := strIn
   stripURI := StrReplace(constructURI, "https://open.spotify.com", "")
   URI := StrReplace("spotify"stripURI, "/", ":")
   clipboard := URI
   Run, %URI%
   return
}

Share(){
   WinGetTitle, np, - ahk_exe Spotify.exe ahk_class Chrome_WidgetWin_0
   If (np == "") {
      return
   }else{
      np := StrReplace("spotify:search:"np, " ", "+")
      clipboard := np
      return
   }
}

DownloadMsgBox() 
{
   DetectHiddenWindows, On
   Process, Exist
   If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
      ControlSetText Button1, Yes
      ControlSetText Button2, Use Default
      return
   }
}

GuiSize:
   If (A_EventInfo = 1)
   WinHide
return

Restore:
   Gui, +LastFound
   WinShow
   WinRestore
return

GuiEscape:
GuiClose:
   DllCall("GDI32.DLL\RemoveFontResourceEx",Str,"circular.ttf",UInt,(FR_PRIVATE:=0x10),Int,0)
ExitApp

2GuiEscape:
2GuiClose:
   Gui, 1: Show,, Spotehfi %Version%
   Gui, 2: Destroy
   Gui, 1: -Disabled
return

Quit(){
   DllCall("GDI32.DLL\RemoveFontResourceEx",Str,"circular.ttf",UInt,(FR_PRIVATE:=0x10),Int,0)
   Exit
}

/* ; ---------------------------------------------------
VALIDATE FILES
*/ ; ---------------------------------------------------

ValidateFiles(){
   If !FileExist("resources/assets")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'assets' in resources folder.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing assets?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/zip/assets.zip
      Quit()
   }
   If !FileExist("resources/assets/btnSettings.png")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'btnSettings.png' in 'assets' folder.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing file?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/assets/btnSettings.png
      Quit()
   }
   If !FileExist("resources/assets/btnShare.png")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'btnShare.png' in 'assets' folder.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing file?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/assets/btnShare.png
      Quit()
   }
   If !FileExist("resources/assets/btnSpotify.png")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'btnSpotify.png' in 'assets' folder.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing file?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/assets/btnSpotify.png
      Quit()
   }
   If !FileExist("resources/assets/btnDownload.png")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'btnDownload.png' in 'assets' folder.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing file?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/assets/btnDownload.png
      Quit()
   }
   If !FileExist("resources/assets/btnYouTube.png")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'btnYouTube.png' in 'assets' folder.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing file?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/assets/btnYouTube.png
      Quit()
   }
   If !FileExist("resources/assets/spotify.ico")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'spotify.ico' in 'assets' folder.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing file?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/assets/Spotify.ico
      Quit()
   }
   If !FileExist("resources/tools")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'tools' folder in resources folder.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing Tools?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/zip/tools.zip
      Quit()
   }
   If !FileExist("resources/tools/ffmpeg.exe")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'ffmpeg.exe' in root directory.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing assets?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/tools/ffmpeg.exe
      Quit()
   }
   If !FileExist("resources/tools/youtube-dl.exe")
   {
      MsgBox, 16, Missing Prerequisites, Unable to locate 'youtube-dl.exe' in root directory.
      Msgbox, 36, Download Prerequisites, Do you wish to download the missing assets?
      IfMsgBox, No
         Quit()
      IfMsgBox, Yes
         Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/tools/youtube-dl.exe
      Quit()
   }
}

/* ; ---------------------------------------------------
GENERATE DATA ELSE USE USER'S PREFERENCE (settings.ini)
*/ ; ---------------------------------------------------

SettingsIni(){
   If !FileExist("settings.ini")
   {
      offerFontChange()
      setDefaultColours()
      setDownloadPath()
   } 
   IniRead, fontSetting, settings.ini, Font, circularFont
   if (fontSetting == "Enabled"){
      setFont()
   }
   getColours()
}

/* ; ---------------------------------------------------
INSTALL CIRCULAR STD BOOK FONT (Optional)
*/ ; ---------------------------------------------------

offerFontChange(){
      Msgbox, 36, Apply Font (Recommended), Do you wish to apply the 'Circular Std Book' font?
      IfMsgBox, No
      {
         IniWrite, Disabled, settings.ini, Font, circularFont
         return
      }
      IfMsgBox, Yes
      {
         IniWrite, Enabled, settings.ini, Font, circularFont        
         if !FileExist("resources/assets/circular.ttf"){
            MsgBox, 16, Missing Font, Unable to locate 'circular.ttf' in 'resources/assets' folder.
            Run, https://github.com/Jxyme/spotehfi-ahk/raw/master/resources/assets/Circular.ttf
            Quit()
         }else{
            setFont()
         return
         }         
      }
}

setFont(){
   DllCall("GDI32.DLL\AddFontResourceEx", Str,"resources/assets/circular.ttf",UInt,(FR_PRIVATE:=0x10), Int,0)
   return
}

/* ; ---------------------------------------------------
SET BACKGROUND & ACCENT COLOURS ON STARTUP
*/ ; ---------------------------------------------------

setDefaultColours(){
   IniWrite, 2B3544, settings.ini, Palette, backgroundCol
   IniWrite, FFC621, settings.ini, Palette, accentCol
   return
}

/* ; ---------------------------------------------------
SET YOUTUBE DOWNLOAD PATH ON STARTUP (Optional)
*/ ; ---------------------------------------------------

setDownloadPath(){
   OnMessage(0x44, "DownloadMsgBox")
   MsgBox, 36, Initial Setup, Do you wish to modify the output directory for downloads?
   OnMessage(0x44, "")
   IfMsgBox, Yes
   {
      FileSelectFolder, CustomDir, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 3
      If (CustomDir = "") {
         dirInQuotes := "Default"
         IniWrite, %dirInQuotes%, settings.ini, Directory, downloadPath
      } Else
         dirInQuotes := CustomDir
         IniWrite, %dirInQuotes%, settings.ini, Directory, downloadPath
      } Else {
         dirInQuotes := "Default"
         IniWrite, %dirInQuotes%, settings.ini, Directory, downloadPath
      } return
}

getColours(){
   IniRead, setBackground, settings.ini, Palette, backgroundCol
   bgColour := setBackground
   IniRead, setAccent, settings.ini, Palette, accentCol
   accentColour := setAccent
   return
}

/* ; ---------------------------------------------------
CHANGE CURSOR FUNCTION (updated to use hwnd)
*/ ; ---------------------------------------------------

WM_MOUSEMOVE(wParam,lParam,msg,hwnd){
   Static Initialize
   
   If (Initialize != 0){

      Global hCurs,eCurs
      Global hSettings,hSpotify,hShare,hYouTube,hDownload   ; Hand Cursor (Main GUI)
      Global hUpdateA,hUpdateB,hUpdateC,hResetA,hResetB,hResetC  ; Hand Cursor (Settings GUI)

      hCurs := DllCall("LoadCursor", "UInt", NULL, "Int", 32649, "UInt")   ; Info Cursor (^w/?)
      eCurs := DllCall("LoadCursor", "UInt", NULL, "Int", 32651, "UInt")   ; Hand Cursor (Link)

      Initialize = 0
   }
   WinGetTitle, np, - ahk_exe Spotify.exe ahk_class Chrome_WidgetWin_0
   If (hwnd = hSettings) || (hwnd = hUpdateA) || (hwnd = hUpdateB) || (hwnd = hUpdateC) || (hwnd = hResetA) || (hwnd = hResetB) || (hwnd = hResetC){
      DllCall("SetCursor", "UInt", hCurs)
   } Else If (np == ""){
      return
   } Else {
   If (hwnd = hSettings) || (hwnd = hSpotify) || (hwnd = hShare) || (hwnd = hYouTube) || (hwnd = hDownload) 
   || (hwnd = hSettings) || (hwnd = hUpdateA) || (hwnd = hUpdateB) || (hwnd = hUpdateC) || (hwnd = hResetA) || (hwnd = hResetB) || (hwnd = hResetC){ ; hwnd instead of Static (suppot multiple GUI's)
      DllCall("SetCursor", "UInt", hCurs)
      }
   }
return
}

/* ; ---------------------------------------------------
ADDTOOLTIP FUNCTION
*/ ; ---------------------------------------------------

AddTooltip(p1,p2:="",p3="") ;AddToolTip 2.0 (Credits to jballi) [https://www.autohotkey.com/boards/viewtopic.php?f=6&t=30079]
{
   Static hTT
   ,CW_USEDEFAULT:=0x80000000
   ,HWND_DESKTOP :=0
   ,TTDT_AUTOPOP:=2
   ,TTS_ALWAYSTIP:=0x1
   ,TTS_NOPREFIX:=0x2
   ,TTF_IDISHWND:=0x1
   ,TTF_SUBCLASS:=0x10
   ,TTI_NONE         :=0
   ,TTI_INFO         :=1
   ,TTI_WARNING      :=2
   ,TTI_ERROR        :=3
   ,TTI_INFO_LARGE   :=4
   ,TTI_WARNING_LARGE:=5
   ,TTI_ERROR_LARGE  :=6
   ,WS_EX_TOPMOST:=0x8
   ,TTM_ACTIVATE      :=0x401
   ,TTM_ADDTOOLA      :=0x404
   ,TTM_ADDTOOLW      :=0x432
   ,TTM_DELTOOLA      :=0x405
   ,TTM_DELTOOLW      :=0x433
   ,TTM_GETTOOLINFOA  :=0x408
   ,TTM_GETTOOLINFOW  :=0x435
   ,TTM_SETDELAYTIME  :=0x403
   ,TTM_SETMAXTIPWIDTH:=0x418
   ,TTM_SETTITLEA     :=0x420
   ,TTM_SETTITLEW     :=0x421
   ,TTM_UPDATETIPTEXTA:=0x40C
   ,TTM_UPDATETIPTEXTW:=0x439
   
   l_DetectHiddenWindows:=A_DetectHiddenWindows
   DetectHiddenWindows On
   
   if not hTT
   {
      hTT:=DllCall("CreateWindowEx"
      ,"UInt",WS_EX_TOPMOST
      ,"Str","TOOLTIPS_CLASS32"
      ,"Ptr",0
      ,"UInt",TTS_ALWAYSTIP|TTS_NOPREFIX
      ,"UInt",CW_USEDEFAULT
      ,"UInt",CW_USEDEFAULT
      ,"UInt",CW_USEDEFAULT
      ,"UInt",CW_USEDEFAULT
      ,"Ptr",HWND_DESKTOP
      ,"Ptr",0
      ,"Ptr",0
      ,"Ptr",0
      ,"Ptr")
      
      SendMessage TTM_SETMAXTIPWIDTH,0,A_ScreenWidth,,ahk_id %hTT%
   }
   
   if p1 is not Integer
   {
      if (p1="Activate")
         SendMessage TTM_ACTIVATE,True,0,,ahk_id %hTT%
      
      if (p1="Deactivate")
         SendMessage TTM_ACTIVATE,False,0,,ahk_id %hTT%
      
      if (InStr(p1,"AutoPop")=1)
      SendMessage TTM_SETDELAYTIME,TTDT_AUTOPOP,p2*1000,,ahk_id %hTT%
      
      if (p1="Title")
      {
         if (StrLen(p2)>99)
         p2:=SubStr(p2,1,99)
         if p3 is not Integer
         p3:=TTI_NONE
         SendMessage A_IsUnicode ? TTM_SETTITLEW:TTM_SETTITLEA,p3,&p2,,ahk_id %hTT%
      }
      
      DetectHiddenWindows %l_DetectHiddenWindows%
      Return hTT
   }
   
   uFlags:=TTF_IDISHWND|TTF_SUBCLASS
   cbSize:=VarSetCapacity(TOOLINFO,(A_PtrSize=8) ? 64:44,0)
   NumPut(cbSize,      TOOLINFO,0,"UInt")
   NumPut(uFlags,      TOOLINFO,4,"UInt")
   NumPut(HWND_DESKTOP,TOOLINFO,8,"Ptr")
   NumPut(p1,          TOOLINFO,(A_PtrSize=8) ? 16:12,"Ptr")
   
   SendMessage
   ,A_IsUnicode ? TTM_GETTOOLINFOW:TTM_GETTOOLINFOA
   ,0
   ,&TOOLINFO
   ,,ahk_id %hTT%
   
   l_RegisteredTool:=ErrorLevel
   
   NumPut(&p2,TOOLINFO,(A_PtrSize=8) ? 48:36,"Ptr")
   
   if l_RegisteredTool
   {
      if StrLen(p2)
      SendMessage
      ,A_IsUnicode ? TTM_UPDATETIPTEXTW:TTM_UPDATETIPTEXTA
      ,0
      ,&TOOLINFO
      ,,ahk_id %hTT%
      else
         SendMessage
      ,A_IsUnicode ? TTM_DELTOOLW:TTM_DELTOOLA
      ,0
      ,&TOOLINFO
      ,,ahk_id %hTT%
   }
   else
      if StrLen(p2)
   SendMessage
   ,A_IsUnicode ? TTM_ADDTOOLW:TTM_ADDTOOLA
   ,0
   ,&TOOLINFO
   ,,ahk_id %hTT%
   
   DetectHiddenWindows %l_DetectHiddenWindows%
   
   Return hTT
}

/* ; ---------------------------------------------------
SHORTCUTS
*/ ; ---------------------------------------------------

*+^c::
   Send, +^c
return

^r::
   Reload
return

*^c::
   Clipboard := ""
   Send ^c
   ClipWait
   openLinkClean()
   spotifyLinkOpen()
return

/* ; ---------------------------------------------------
CONVERT & SEARCH SPOTIFY URI FUNCTIONS
*/ ; ---------------------------------------------------

spotifyLinkOpen(){
   If (RegExMatch(Clipboard, "spotify:search:\S*", result)
   || RegExMatch(Clipboard, "spotify:track:\S*", result)
   || RegExMatch(Clipboard, "spotify:playlist:\S*", result)
   || RegExMatch(Clipboard, "spotify:album:\S*", result)
   || RegExMatch(Clipboard, "spotify:artist:\S*", result)
   || RegExMatch(Clipboard, "spotify:user:\S*", result)) 
   {   
      Run, %result%
   }else
   {
      return
   }
}

openLinkClean(){
   If (RegExMatch(Clipboard, "(?:\/track)\S*", constructURI)
      || RegExMatch(Clipboard, "(?:\/playlist)\S*", constructURI)
      || RegExMatch(Clipboard, "(?:\/album)\S*", constructURI)
      || RegExMatch(Clipboard, "(?:\/artist)\S*", constructURI)
      || RegExMatch(Clipboard, "(?:\/user)\S*", constructURI)) 
   {     
      ConstructToSearch(constructURI)
   }
   else
   {
      return
   }
}