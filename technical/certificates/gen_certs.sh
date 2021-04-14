#!/usr/software/bin/bash

# References:
# This script is for OpenSSL 1.0.1e, specifying the SAN is easier in later
# releases.
#
# - "openssl version -d" to determine openssl install directory
#    https://stackoverflow.com/questions/37035300/how-to-determine-the-default-location-for-openssl-cnf
# - Using pseudo-files for temporary file descriptors
#   https://unix.stackexchange.com/questions/63923/pseudo-files-for-temporary-data
# - Using OpenSSL to generate certs with custom CA.
#   https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309
# - Adding SAN to cert in OpenSSL 1.0.1
#   https://security.stackexchange.com/questions/74345/provide-subjectaltname-to-openssl-directly-on-the-command-line

# Specify specific locations here
OPENSSL="/usr/software/bin/openssl"
OPENSSL_CNF="/usr/software/share/openssl/openssl.cnf"

PREFIX=$1

CA_CERT="${PREFIX}_root_ca.crt"
CA_KEY="${PREFIX}_root_ca.key"
NODE_CSR="${PREFIX}_node.csr"
NODE_CERT="${PREFIX}_node.crt"
NODE_KEY="${PREFIX}_node.key"

$OPENSSL req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
    -out "$CA_CERT" -keyout "$CA_KEY" \
    -subj "/CN=netapp.com/C=US/ST=California/O=NetApp Inc/OU=ca"

# If adding the SAN to a req/self-signed cert, instead do:
#    -reqexts SAN \
#    -config <(cat $OPENSSL_CNF \
#            <(printf "\n[SAN]\nsubjectAltName=DNS:example.com,DNS:www.example.com\n")) \

$OPENSSL req -newkey rsa:2048 -sha256 -nodes \
    -out "$NODE_CSR" -keyout "$NODE_KEY" \
    -subj "/CN=netapp.com/C=US/ST=California/O=NetApp Inc"

            #<(printf "\n[SAN]\nsubjectAltName=DNS:10.234.135.93,DNS:10.234.236.40,IP:10.234.135.93,IP:10.234.236.40\n")) \
$OPENSSL x509 -req -in "$NODE_CSR" -CA "$CA_CERT" -CAkey "$CA_KEY" \
    -extensions SAN \
    -extfile <(cat $OPENSSL_CNF \
            <(printf "\n[SAN]\nsubjectAltName=DNS:10.234.135.93,DNS:10.234.236.40\n")) \
    -CAcreateserial -days 365 -sha256 -out "$NODE_CERT"
