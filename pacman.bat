@echo off

cd /d %~dp0

processing-java --force --sketch="%cd%\main" --run

@REM processing-java --force --sketch="%cd%\main" --output="%cd%\out" --run

@REM processing-java --force --sketch="%cd%\main" --export --platform=windows --output="%cd%\out"