@ECHO OFF
SETLOCAL EnableExtensions
SET /P CHOOSE_R=Do you want to choose R or set VE library?(y/n):
IF /I "%CHOOSE_R%"=="y"	GOTO CHOSEN_R 
IF /I "%CHOOSE_R%"=="n"	GOTO CHOSEN_VE_LIB

:CHOSEN_R
SET /P WHICH_R=Provide path for the R installation directory:

:CHOSEN_VE_LIB
SET /P VE_LIB=Copy and paste the ve-lib path:
ECHO R_LIBS_USER = "%VE_LIB%" > .Renviron
IF NOT DEFINED WHICH_R GOTO End 

TITLE VE PACKAGES INSTALL
SET "App[1]=VESimHouseholdsMetro"
SET "App[2]=VEPowertrainsAndFuelsAP2022"
SET "App[3]=VEPowertrainsAndFuelsSTS"
SET "App[4]=VETravelDemandWFH"
SET "App[5]=VERSPMMetroModels"
SET "App[6]=All Modules"

:: Display Menu
SET "Message="
:Menu
CLS
ECHO.%Message%
ECHO.
ECHO.  VE Package Installation
ECHO.
SET "x=0"
:MenuLoop
SET /a "x+=1"
IF DEFINED App[%x%] (
    CALL ECHO   %x%. %%App[%x%]%%
    GOTO MenuLoop
)
ECHO.

:: Prompt User for Choice
:Prompt
SET "Input="
SET /p "Input=Select modules to install:"

:: Validate Input [Remove Special Characters]
IF NOT DEFINED Input GOTO Prompt
SET "Input=%Input:"=%"
SET "Input=%Input:^=%"
SET "Input=%Input:<=%"
SET "Input=%Input:>=%"
SET "Input=%Input:&=%"
SET "Input=%Input:|=%"
SET "Input=%Input:(=%"
SET "Input=%Input:)=%"
:: Equals are not allowed in variable names
SET "Input=%Input:^==%"
CALL :Validate %Input%

:: Process Input
CALL :Process %Input%
GOTO End


:Validate
SET "Next=%2"
IF NOT DEFINED App[%1] (
    SET "Message=Invalid Input: %1"	
    GOTO Menu
)
IF DEFINED Next SHIFT & GOTO Validate
GOTO :eof


:Process
SET "Next=%2"
CALL SET "App=%%App[%1]%%"

:: Run Installations
:: Specify all of the installations for each app.
:: Step 2. Match on the application names and perform the installation for each
IF "%App%" EQU "VESimHouseholdsMetro" ECHO Installing %App% && CALL "%WHICH_R%\bin\R.exe" CMD INSTALL -l "%VE_LIB%" "%~dp0\%App%"
IF "%App%" EQU "VEPowertrainsAndFuelsAP2022" ECHO Installing %App% && CALL "%WHICH_R%\bin\R.exe" CMD INSTALL -l "%VE_LIB%" "%~dp0\%App%"
IF "%App%" EQU "VEPowertrainsAndFuelsSTS" ECHO Installing %App% && CALL "%WHICH_R%\bin\R.exe" CMD INSTALL -l "%VE_LIB%" "%~dp0\%App%"
IF "%App%" EQU "VETravelDemandWFH" ECHO Installing %App% && CALL "%WHICH_R%\bin\R.exe" CMD INSTALL -l "%VE_LIB%" "%~dp0\%App%"
IF "%App%" EQU "VERSPMMetroModels" ECHO Installing %App% && CALL "%WHICH_R%\bin\R.exe" CMD INSTALL -l "%VE_LIB%" "%~dp0\%App%"
IF "%App%" EQU "All Modules" (
CALL :Process 1 2 3 4 5 6
)

:: Prevent the command from being processed twice if listed twice.
SET "App[%1]="
IF DEFINED Next SHIFT & GOTO Process
GOTO :eof


:End
ENDLOCAL
