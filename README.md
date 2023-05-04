# r-parallel-nesi

A set of parallel R scripts that can be run on NeSI

## How to run the test suite on NeSI

Make sure to use Cylc 8 or later
```
export CYLC_VERSION=8.1.1
```

Install the workflow
```
cd cylc-src/r-parallel-nesi/
cylc install
```

Run the workflow
```
cylc play r-parallel-nesi -n
```

## Adjusting the number of tasks

In cylc-src/r-parallel-nesi/flow.cylc, change 
```
      NTASKS=10000
```
You will need to install again the workflow (see above).
