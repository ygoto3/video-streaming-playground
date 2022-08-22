kid=`cat keys/kid.txt | xxd -r -p | base64 | tr '/+' '_-' | tr -d '='`
key=`cat keys/key.txt | xxd -r -p | base64 | tr '/+' '_-' | tr -d '='`
echo "kid: $kid"
echo "key: $key"

