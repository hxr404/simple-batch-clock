@echo off
cd/d %temp%
if exist "%temp%\Uhr - Settings.txt" set/p color=<"%temp%\Uhr - Settings.txt"
color 0F
if defined color color %color%
title Uhr
mode con lines=5 cols=15
:start
cls
echo.
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³  %time:~0,-3%  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ
ping -4 -n 2 -w 1000 localhost >nul
goto start
pause
