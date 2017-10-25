@rem Copyright (c) MediaArea.net SARL. All Rights Reserved.
@rem
@rem Use of this source code is governed by a BSD-style license that can
@rem be found in the License.html file in the root of the source tree.
@rem

@rem echo off

rem --- Search binaries ---
set BPATH=
if exist "%~dp0\..\..\..\MediaArea-Utils-Binaries" set BPATH="%~dp0\..\..\..\MediaArea-Utils-Binaries"
if exist "%~dp0\..\..\MediaArea-Utils-Binaries" set BPATH="%~dp0\..\..\MediaArea-Utils-Binaries"
if "%BPATH%"=="" (
    echo "ERROR: binaries path not found"
    exit /b 1
)

@rem --- Clean up ---
del   MediaInfo_GUI_Windows_x64.exe
del   MediaInfo_GUI_Windows_x64_WithoutInstaller.7z
rmdir MediaInfo_GUI_Windows_x64 /S /Q
mkdir MediaInfo_GUI_Windows_x64


@rem --- Copying : Exe ---
copy  ..\Project\BCB\GUI\Win32\Release\MediaInfo_GUI.exe MediaInfo_GUI_Windows_x64\MediaInfo.exe
xcopy ..\..\MediaInfoLib\Project\MSVC2017\x64\Release\MediaInfo.dll MediaInfo_GUI_Windows_x64\ /S
copy  ..\..\MediaInfoLib\Project\MSVC2017\Win32\Release\MediaInfo.dll MediaInfo_GUI_Windows_x64\MediaInfo_i386.dll
xcopy ..\..\MediaInfoLib\Project\MSVC2017\x64\Release\MediaInfo_InfoTip.dll MediaInfo_GUI_Windows_x64\ /S

@rem --- Copying : Plugins ---
xcopy ..\Source\Resource\Plugin\* MediaInfo_GUI_Windows_x64\Plugin\ /S

@rem --- Copying : libCURL --
copy %BPATH%\Windows\libcurl\Win32\Release\LIBCURL.DLL MediaInfo_GUI_Windows_x64\
copy %BPATH%\Windows\libcurl\curl-ca-bundle.crt MediaInfo_GUI_Windows_x64\

@rem --- Copying : Information files ---
copy ..\License.html MediaInfo_GUI_Windows_x64\
copy ..\History_GUI.txt MediaInfo_GUI_Windows_x64\History.txt
copy ReadMe_GUI_Windows.txt MediaInfo_GUI_Windows_x64\ReadMe.txt


rem --- Compressing Archive ---
cd MediaInfo_GUI_Windows_x64\
%BPATH%\Windows\7-Zip\7z a -r -t7z -mx9 ..\MediaInfo_GUI_Windows_x64_WithoutInstaller.7z *
cd ..

rem --- Clean up ---
if "%1"=="SkipCleanUp" goto SkipCleanUp
rmdir MediaInfo_GUI_Windows_x64\ /S /Q
:SkipCleanUp
