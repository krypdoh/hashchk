===========================================================

Script:  hashchk.cmd
Version:  1.0

===========================================================

This script has three parameters.  The first is required and the second
and third are figured out contextually.  The first parameter is the file
to check hash(es) on.

If the second parameter matches an available hash method, it is used
as the hash method to check.  If the third parameter is also provided,
it is compared to the computed hash, and a success/fail message
is displayed.

If the second parameter IS NOT an available hash method, it is used as
a hash to verify against the file and all available hashes are used.
When done, a success/fail message is displayed.

If the second parameter IS NOT PROVIDED, all available hashes are
displayed.

===========================================================

Usage:
hashchk <filename> [MD2|MD4|MD5|SHA1|SHA256|SHA384|SHA512] [hash]

Example Usage:

C:\haskchk.cmd filename.csv MD5 21df1dbec3c229be9ea5cd80c42442e7

Example Output:

Checking "filename.csv" against hash method MD5...
MD5=21df1dbec3c229be9ea5cd80c42442e7

The file "filename.csv" matched
MD5 21df1dbec3c229be9ea5cd80c42442e7.

===========================================================
