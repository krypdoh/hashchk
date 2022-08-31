# hashchk
Computes and checks the hash of a given file

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
