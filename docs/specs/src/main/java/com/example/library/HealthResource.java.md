---
kind: file
source_paths: [src/main/java/com/example/library/HealthResource.java]
file: { source_hash: d17d07feb5f8092c8cb1a1ced9c9b64b88ee284e78e9e091232df12c1138e299, deps_hash: af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262, spec_hash: 2eb9ef8bbc0ab040b01c1999dfca9916cfce3940fb1316160eeacf34069af237 }
symbols:
  src/main/java/com/example/library/HealthResource.java::HealthResource: { source_hash: c90b2c9146c426f18ebe170a0a322761328360df215abac372629b4a8e520991, deps_hash: af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262, spec_hash: dfcf2d4c559c584f64e07fd1518a96abc93686362d4368d5a7c6e3e081faf8e6 }
---
# src/main/java/com/example/library/HealthResource.java
## Summary
A liveness-check endpoint with no connection to the library domain -- exists only to answer "is the process up," never touches Book or any of the checkout logic.

## `HealthResource`
`@Path("/health")
public class HealthResource`
### Summary
A trivial liveness check endpoint, unrelated to the library domain.
### Behavior
GET /health always returns the literal string "OK" -- no dependencies on Book or any other part of the service, deliberately, since it exists only to answer "is the process up."
### Depends on
- externals: jakarta.ws.rs
