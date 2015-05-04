@echo off

set FrameworkPath=%SystemRoot%\Microsoft.NET\Framework\v2.0.50727
if exist "%FrameworkPath%\csc.exe" goto :start
set FrameworkPath=%SystemRoot%\Microsoft.NET\Framework\v4.0.30319
if exist "%FrameworkPath%\csc.exe" goto :start
:start

if exist ..\build rd /q /s ..\build
md ..\build

pushd ..\source
if exist obj rd /q /s obj
%FrameworkPath%\csc.exe /target:library /out:..\build\Mapack.dll /doc:..\build\Mapack.xml *.cs /keyfile:KeyPair.snk %1 
popd

pushd ..\test
if exist obj rd /q /s obj
%FrameworkPath%\csc.exe /target:exe /out:..\build\Test.exe *.cs %1 /r:..\build\Mapack.dll
popd
