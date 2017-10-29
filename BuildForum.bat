::    @author Morten Terhart
::    * Creation Date: 26.10.17
::
::    * Script for automatic compilation of Java source files and reporting the results
::    * Includes a lot of safety checks for requirements

:: Disable echoing all commands with a prompt
@echo off

:: Evaluate variables within exclamation marks at the time of execution,
:: not on parsing
SetLocal EnableDelayedExpansion

:: Define script constants
set usage_message=usage: %0 [--help]
set webapp_name=Forum-INF16B
set /A "exit_status=0"

set display_usage=true
IF NOT "%1" == "-h" IF NOT "%1" == "--help" (
	set display_usage=false
)

IF "%display_usage%" == "true" (
	echo %usage_message%
	exit /B 0
)

echo | set /p dummy=[%webapp_name%]: Checking if current directory is the project's root directory ...
IF EXIST "WEB-INF" (
	echo  successful!
	echo | set /p dummy=[%webapp_name%]: Checking if WEB-INF\classes is existent ...
	IF EXIST "WEB-INF\classes" (
		echo  existent!
	) ELSE (
		echo  not existent!
		echo [%webapp_name%]: Creating new directory 'WEB-INF\classes' for bytecode.
		mkdir WEB-INF\classes
	)

	call :launchBanner

	echo [%webapp_name%]: Switching to directory 'WEB-INF'.
	cd WEB-INF

	echo _______________________________________________
	echo.
	echo.

	echo [%webapp_name%]: Checking if the Java compiler is correctly installed.
	where /Q javac
	IF ERRORLEVEL 0 IF NOT ERRORLEVEL 1 (
		echo | set /p dummy=[%webapp_name%]: Looking after Java sources in 'WEB-INF\src' ...
		IF EXIST "src\User.java" (
			echo  found!
			echo.

			set error_index=0
			set erroneous_files[0]=
			echo [%webapp_name%]: Compiling Java sources in 'WEB-INF\src'.
		
			FOR %%J IN (.\src\*.java) DO (
				echo [%webapp_name%]: Compiling %%J ...
				javac -cp "lib/*:classes" -encoding "UTF-8" -d ".\classes" -Xlint:static %%J
				IF ERRORLEVEL 1 (
					echo   ^> Errors detected
					set erroneous_files[!error_index!]=%%J
					set /A "error_index+=1"
					set /A "exit_status=1"	
				) ELSE (
					echo   ^> No errors
				)
			)
			
			echo _______________________________________________
			echo.
			echo.
			
			IF !exit_status! NEQ 0 (
				call :error The following files had compiling issues:
				
				:: First determine the length of array erroneous_files
				set /A array_length=0
				call :arrayLength
				
				set /A array_length-=1
				
				:: Iterate over the array using the length to output all erroneous files
				FOR /L %%i IN (0, 1, !array_length!) DO (
					echo   ^> !erroneous_files[%%i]!
				)
				
				call :error Check them again and fix the errors!
			) ELSE (
				echo [%webapp_name%]: No compilation errors were detected.
			)
			
			echo.
			echo [%webapp_name%]: The Java bytecode was moved to 'WEB-INF\classes'.
		) ELSE (
			echo  not found!
			echo.
			echo [%webapp_name%]: Could not find any java files in 'WEB-INF\src'.
			echo [%webapp_name%]: Make sure they are inside 'WEB-INF\src'.
			call :error No Java source files found
			set exit_status=2
		)
	) ELSE (
		echo [%webapp_name%]: The 'javac' executable could not be found!
		echo [%webapp_name%]: Make sure you have Java 8 correctly installed and the binaries folder appears in your PATH variable.
		call :error insufficient Java 8 installation
		set exit_status=2;
	)
	echo [%webapp_name%]: Changing back to root directory %0.
	cd ..
) ELSE (
	echo  failed!
	echo [%webapp_name%]: Switch to the project's directory %0 first to execute this script:
	echo    $ cd %0
	call :error Executing from wrong directory
	set exit_status=2
)

exit /B !exit_status!

:: Function to display a fancy banner at startup
:launchBanner
	echo.
 	echo    _______   ______   .______       __    __  .___  ___.        __  .__   __.  _______ __     __   .______   
	echo   ^|   ____^| /  __  \  ^|   _  \     ^|  ^|  ^|  ^| ^|   \/   ^|       ^|  ^| ^|  \ ^|  ^| ^|   ____/_ ^|   / /   ^|   _  \  
	echo   ^|  ^|__   ^|  ^|  ^|  ^| ^|  ^|_^)  ^|    ^|  ^|  ^|  ^| ^|  \  /  ^|       ^|  ^| ^|   \^|  ^| ^|  ^|__   ^| ^|  / /_   ^|  ^|_^)  ^| 
	echo   ^|   __^|  ^|  ^|  ^|  ^| ^|      /     ^|  ^|  ^|  ^| ^|  ^|\/^|  ^|       ^|  ^| ^|  . `  ^| ^|   __^|  ^| ^| ^| '_ \  ^|   _  ^<  
	echo   ^|  ^|     ^|  `--'  ^| ^|  ^|\  \----.^|  `--'  ^| ^|  ^|  ^|  ^|       ^|  ^| ^|  ^|\   ^| ^|  ^|     ^| ^| ^| ^(_^) ^| ^|  ^|_^)  ^| 
	echo   ^|__^|      \______/  ^| _^| `._____^| \______/  ^|__^|  ^|__^|       ^|__^| ^|__^| \__^| ^|__^|     ^|_^|  \___/  ^|______/  
	echo.
exit /B 0

:: Function to output a uniform error message
:error
	echo ERROR: %* >&2
exit /B 0

:arrayLength
	set /A length=0

	:nextIndexLoop
	IF DEFINED erroneous_files[!length!] (
		set /A length+=1
		GOTO :nextIndexLoop
	)
	set /A array_length=%length%
exit /B 0
