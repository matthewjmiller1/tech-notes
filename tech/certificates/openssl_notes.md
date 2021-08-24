# OpenSSL Notes

## Commands
- Show certificate details
    ```
    openssl x509 -in certificate.crt -text -noout
    ```
- Validate certificates using mTLS and IP verification of the SAN field (OpenSSL
  1.1.1 commands)
    ```
    openssl s_server -key cert.key -cert cert.crt -CAfile peer_ca.crt -accept 54321 -Verify 3 -state -quiet -verify_return_error
    ```
    ```
    openssl11 s_client -key cert.key -cert cert.crt -CAfile peer_ca.crt -connect <server IP>:54321 -verify 3 -state -quiet -verify_return_error -verify_ip <SAN IP>
    ```
