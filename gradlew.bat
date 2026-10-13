@echo off
setlocal
cd /d "%~dp0"
set "GRADLE_VERSION=8.14.3"
if not defined GRADLE_USER_HOME set "GRADLE_USER_HOME=%USERPROFILE%\.gradle"
set "GRADLE_HOME=%GRADLE_USER_HOME%\ci-matrix-distributions\gradle-%GRADLE_VERSION%"
if not exist "%GRADLE_HOME%in\gradle.bat" (
  echo Downloading Gradle %GRADLE_VERSION%...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $base=Join-Path $env:GRADLE_USER_HOME 'ci-matrix-distributions'; New-Item -ItemType Directory -Force -Path $base | Out-Null; $zip=Join-Path $env:TEMP 'gradle-ci-matrix.zip'; Invoke-WebRequest -Uri ('https://services.gradle.org/distributions/gradle-'+$env:GRADLE_VERSION+'-bin.zip') -OutFile $zip; Expand-Archive -Path $zip -DestinationPath $base -Force; Remove-Item $zip -Force"
  if errorlevel 1 exit /b 1
)
call "%GRADLE_HOME%in\gradle.bat" %*
exit /b %ERRORLEVEL%
