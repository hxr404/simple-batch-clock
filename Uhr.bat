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
echo 旼컴컴컴컴컴커
echo �  %time:~0,-3%  �
echo 읕컴컴컴컴컴켸
ping -4 -n 2 -w 1000 localhost >nul
goto start
pause