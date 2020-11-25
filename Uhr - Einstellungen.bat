@echo off
setlocal disableDelayedExpansion
title Uhr Einstellungen
set user=Benutzerdefiniert
:start
color 07
cls
echo Farbe der Uhr auswÑhlen:
echo.
echo 1 = Schwarz-Wei·
echo 2 = Wei·-Schwarz
if not %user%==Benutzerdefiniert call :c 0F "3 = Farbe " & call :c %user% "%user%" /n
if %user%==Benutzerdefiniert echo 3 = %user%
echo 4 = Beenden
if exist "%temp%\Uhr - Settings.txt" set/p color=<"%temp%\Uhr - Settings.txt"
if exist "%temp%\Uhr - Settings.txt" call :c 07 "5 = Einstellung " & call :c %color% "%color:~0,-2%" & call :c 07 " zurÅcksetzen." /n
set auswahl=leer
set/p auswahl="Auswahl eingeben: "
if %auswahl%==1 echo 0F >"%temp%\Uhr - Settings.txt" & echo. & echo Farbe festgelegt & pause & exit
if %auswahl%==2 echo F0 >"%temp%\Uhr - Settings.txt" & echo. & echo Farbe festgelegt & pause & exit
if %auswahl%==3 goto user
if %auswahl%==4 echo. & echo Wird beendet... & pause & exit
if exist "%temp%\Uhr - Settings.txt" (
    if %auswahl%==5 del/f /q "%temp%\Uhr - Settings.txt" & echo. & echo ZurÅckgesetzt. & pause & goto start
)
echo ungÅltige Eingabe
pause
goto start

:user
if not %user%==Benutzerdefiniert echo %user% >"%temp%\Uhr - Settings.txt" & echo. & echo Farbe festgelegt & pause & exit
cls
color 0F
setlocal disableDelayedExpansion
echo Farbattribute werden durch ZWEI hexadezimale Zeichen angegeben - das erste
echo bezieht sich auf den Hintergrund, das zweite auf den Vordergrund. Jedes Zeichen
echo kann einen der folgenden Werte annehmen:
echo.
call :c 07 "     " & call :c 80 "0 = Schwarz" & call :c 08 "     8 = Grau" /n
call :c 01 "     1 = Blau" & call :c 09 "        9 = Hellblau" /n
call :c 02 "     2 = GrÅn" & call :c 0A "        A = HellgrÅn" /n
call :c 03 "     3 = TÅrkis" & call :c 0B "      B = HelltÅrkis" /n
call :c 04 "     4 = Rot" & call :c 0C "         C = Hellrot" /n
call :c 05 "     5 = Lila" & call :c 0D "        D = Helllila" /n
call :c 06 "     6 = Gelb" & call :c 0E "        E = Hellgelb" /n
call :c 07 "     7 = Hellgrau" & call :c 0F "    F = Wei·" /n
echo.
echo Beispiele:
echo.
call :c 02 "02 Schwarz-GrÅn" /n
call :c 0A "0A Schwarz-HellgrÅn" /n
call :c DE "DE Hellila-Hellgelb" /n
endlocal
set user=leer
set/p user="Farbcode eingeben: "
if not %user%==leer goto start
echo Geben Sie etwas ein.
pause
goto user

::::::::::::::::::::::::::::::::::::.
:c
setlocal enableDelayedExpansion
:colorPrint Color  Str  [/n]
setlocal
set "s=%~2"
call :colorPrintVar %1 s %3
exit /b
:colorPrintVar  Color  StrVar  [/n]
if not defined DEL call :initColorPrint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorPrint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorPrint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
exit /b
:initColorPrint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
exit /b
:cleanupColorPrint
2>nul del "%temp%\'"
2>nul del "%temp%\colorPrint.txt"
>nul subst ': /d
exit /b
