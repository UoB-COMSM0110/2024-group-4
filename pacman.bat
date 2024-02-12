@echo off

cd /d %~dp0

processing-java --force --sketch="%cd%\main" --output="%cd%\out" --run
