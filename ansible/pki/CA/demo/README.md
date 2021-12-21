## step CA setup

### create internal CA cert/key
```
step certificate create demo-internal-ca-root demo-internal-ca-root-cert.pem demo-internal-ca-root-key.pem \
	--insecure --no-password --profile root-ca
step certificate create demo-internal-ca-int1 demo-internal-ca-int1-cert.pem demo-internal-ca-int1-key.pem \
	--insecure --no-password --profile intermediate-ca --ca demo-internal-ca-root-cert.pem --ca-key demo-internal-ca-root-key.pem
```

### create external CA cert/key
```
step certificate create demo-external-ca-root demo-external-ca-root-cert.pem demo-external-ca-root-key.pem \
	--insecure --no-password --profile root-ca
step certificate create demo-external-ca-int1 demo-external-ca-int1-cert.pem demo-external-ca-int1-key.pem \
	--insecure --no-password --profile intermediate-ca --ca demo-external-ca-root-cert.pem --ca-key demo-external-ca-root-key.pem
```

