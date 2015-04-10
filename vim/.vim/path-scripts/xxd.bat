@echo off
rem -- Run xxd --

set VIM_EXE_DIR=C:\Program Files (x86)\Vim\vim74
if exist "%VIM%\vim74\xxd.exe" set VIM_EXE_DIR=%VIM%\vim74
if exist "%VIMRUNTIME%\xxd.exe" set VIM_EXE_DIR=%VIMRUNTIME%

if exist "%VIM_EXE_DIR%\xxd.exe" goto havexxd
echo "%VIM_EXE_DIR%\xxd.exe" not found
goto eof

:havexxd

"%VIM_EXE_DIR%\xxd.exe"  %*
goto eof


:eof
