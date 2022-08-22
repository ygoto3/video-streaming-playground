mkdir -p key
openssl rand 16 | xxd -ps > key/kid.txt
openssl rand 16 | xxd -ps > key/key.txt

