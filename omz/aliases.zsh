# Miscellaneous
alias guid='uuidgen | tr "[:upper:]" "[:lower:]"'
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"

# Aliases for URL Encoding and Decoding via pipe or string (encode will also encode slashes)
# Reference https://unix.stackexchange.com/a/216318
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote(  sys.argv[1] if len(sys.argv) > 1 else sys.stdin.read()[0:-1], \"\"))"'
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote(sys.argv[1] if len(sys.argv) > 1 else sys.stdin.read()[0:-1]))"'