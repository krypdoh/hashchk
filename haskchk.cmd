@echo off

REM ============================================================
REM =
REM = Script:  hashchk.cmd
REM = Version:  1.0
REM =
REM = 
REM ============================================================
REM =
REM = This script has three parameters.  The first is required and the second
REM = and third are figured out contextually.  The first parameter is the file
REM = to check hash(es) on.
REM =
REM = If the second parameter matches an available hash method, it is used
REM = as the hash method to check.  If the third parameter is also provided,
REM = it is compared to the computed hash, and a success/fail message
REM = is displayed.
REM =
REM = If the second parameter IS NOT an available hash method, it is used as
REM = a hash to verify against the file and all available hashes are used.
REM = When done, a success/fail message is displayed.
REM =
REM = If the second parameter IS NOT PROVIDED, all available hashes are
REM = displayed.
REM =
REM = Usage:
REM = hashchk <filename> [MD2|MD4|MD5|SHA1|SHA256|SHA384|SHA512] [hash]
REM = 
REM = Example Usage:
REM = 
REM = C:\haskchk.cmd filename.csv MD5 21df1dbec3c229be9ea5cd80c42442e7
REM =
REM = Example Output:
REM = 
REM = Checking "filename.csv" against hash method MD5...
REM = MD5=21df1dbec3c229be9ea5cd80c42442e7
REM = 
REM = The file "filename.csv" matched
REM = MD5 21df1dbec3c229be9ea5cd80c42442e7.
REM = 
REM ============================================================

REM -- INITIALIZATION
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set hashes=MD2 MD4 MD5 SHA1 SHA256 SHA384 SHA512
set file="%~1"
set hashcheck=%~2
if "%~2" == "" set hashcheck=none
set match=n
set hashmethod=none
set hashfound=none
set method=checkall

REM ============================================================

REM -- IF NO PARAMTERS PROVIDED OR FILE DOES NOT EXIST, DISPLAY USAGE
if not exist !file! (
	cls
	echo USAGE: %~n0 FILE [HASH [CHECK]]
	echo
	echo OPTION 1:
	echo If only the file is specified, all available hashes will be displayed.
	echo OPTION 2:
	echo if FILE and HASH are specified, the hash will be compared to all available
	echo hashes and a success/fail message will indicate if a match was found.
	echo OPTION 3:
	echo This is like option 2 except that HASH is one of the available hashes
	echo and is validated against CHECK, if provided.
)

REM ============================================================

REM -- CHECK IF PARAMETER 2 IS A HASH METHOD AND INITIALIZE
for %%f in (%hashes%) do (
	if /i %%f == !hashcheck! (
		set hashmethod=%%f
		set method=checkone
		if "%~3" == "" (
			set hashcheck=none
		) else (
			set hashcheck=%~3
		)
	)
)

REM ============================================================

REM -- IF NO HASH METHOD WAS PROVIDED, CHECK ALL HASHES
if !method! == checkall (
	cls
	echo Checking !file! against all hashes %hashes%...
	for %%f in (%hashes%) do (
		for /f "tokens=*" %%g in ('certUtil -hashfile !file! %%f ^| findstr /v "hash"') do (
			REM -- This check will not return anything if hashcheck == none.
			if /i "%%~g" == "!hashcheck!" (
				set match=y
				set hashmethod=%%f
				set hashfound=%%g
			)
			echo %%~f=%%~g
			echo.
		)
	)

	REM -- The success and failure messages are only displayed if hashcheck != none.
	if !match! == y (
		echo The file !file! matched
		echo !hashmethod! !hashfound!.
	) else (
		if not !hashcheck! == none (
			echo The file !file! hash
			echo did not match any of the calculated
			echo %hashes%
			echo hashes.
		)
	)
)

REM ============================================================

REM -- If a hash method is supplied, this is used.
if !method! == checkone (
	cls
	echo Checking !file! against hash method !hashmethod!...
	for /f "tokens=*" %%g in ('certUtil -hashfile !file! !hashmethod! ^| findstr /v "hash"') do (
		REM -- This check will not return anything if hashcheck == none.
		if "%%~g" == "!hashcheck!" (
			set match=y
			set hashfound=%%g
		)
		echo !hashmethod!=%%~g
		echo.
	)

	REM -- The success and failure messages are only displayed if hashcheck != none.
	if !match! == y (
		echo The file !file! matched
		echo !hashmethod! !hashfound!.
	) else (
		if not !hashcheck! == none (
			echo The file !file! hash
			echo did not match any of the calculated
			echo %hashes%
			echo hashes.
		)
	)
)

REM -- Not required since this is the end of the script, but there
REM -- for completeness.
endlocal
