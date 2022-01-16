# High Performance LINPACK

[High Performance LINPACK](https://www.netlib.org/benchmark/hpl/) (HPL) is a software package that solves a (random) dense linear system in double precision (64 bits) arithmetic on distributed-memory computers. The HPL package provides a testing and timing program to quantify the accuracy of the obtained solution.

Read more about [Intel oneAPI Benchmark HPL](https://www.intel.com/content/www/us/en/develop/documentation/onemkl-linux-developer-guide/top/intel-oneapi-math-kernel-library-benchmarks/intel-optimized-linpack-benchmark-for-linux.html).

## Dependencies

- [Intel oneAPI MKL](https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl.html)

## Creating HPL input file

```
HPLinpack benchmark input file
Innovative Computing Laboratory, University of Tennessee
HPL.out      output file name (if any)
6            device out (6=stdout,7=stderr,file)
1            # of problems sizes (N)
1000         Ns
1            # of NBs
192 256      NBs
1            PMAP process mapping (0=Row-,1=Column-major)
1            # of process grids (P x Q)
3            Ps
4            Qs
16.0         threshold
1            # of panel fact
2 1 0        PFACTs (0=left, 1=Crout, 2=Right)
1            # of recursive stopping criterium
2            NBMINs (>= 1)
1            # of panels in recursion
2            NDIVs
1            # of recursive panel fact.
1 0 2        RFACTs (0=left, 1=Crout, 2=Right)
1            # of broadcast
0            BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)
1            # of lookahead depth
0            DEPTHs (>=0)
0            SWAP (0=bin-exch,1=long,2=mix)
1            swapping threshold
1            L1 in (0=transposed,1=no-transposed) form
1            U  in (0=transposed,1=no-transposed) form
0            Equilibration (0=no,1=yes)
8            memory alignment in double (> 0)
```

## Running HPL on a cluster

### Shared-memory

```
./runme_xeon64
```

### Distributed-memory

```
./runme_intel64_dynamic
```

## Output

A portion of output:

```
================================================================================
HPLinpack 2.1  --  High-Performance Linpack benchmark  --   October 26, 2012
Written by A. Petitet and R. Clint Whaley,  Innovative Computing Laboratory, UTK
Modified by Piotr Luszczek, Innovative Computing Laboratory, UTK
Modified by Julien Langou, University of Colorado Denver
================================================================================
...
content skipped
...
N        :   50000
NB       :     192
PMAP     : Column-major process mapping
P        :       3
Q        :       4
PFACT    :   Right
NBMIN    :       2
NDIV     :       2
RFACT    :   Crout
BCAST    :   1ring
DEPTH    :       0
SWAP     : Binary-exchange
L1       : no-transposed form
U        : no-transposed form
EQUIL    : no
ALIGN    :    8 double precision words
--------------------------------------------------------------------------------

....
content skipped
....
castor          : Column=029760 Fraction=0.595 Kernel=301530.44 Mflops=359513.53
castor          : Column=030912 Fraction=0.615 Kernel=296401.39 Mflops=358633.49
castor          : Column=031872 Fraction=0.635 Kernel=288518.77 Mflops=357777.99
castor          : Column=032832 Fraction=0.655 Kernel=275671.09 Mflops=357173.61
castor          : Column=033792 Fraction=0.675 Kernel=261768.88 Mflops=356300.48
castor          : Column=034752 Fraction=0.695 Kernel=251046.82 Mflops=355550.94
castor          : Column=039936 Fraction=0.795 Kernel=216555.89 Mflops=350960.15
castor          : Column=044928 Fraction=0.895 Kernel=142837.25 Mflops=347347.11
castor          : Column=049920 Fraction=0.995 Kernel=60197.71 Mflops=345636.08
================================================================================
T/V                N    NB     P     Q               Time                 Gflops
--------------------------------------------------------------------------------
WC00C2R2       50000   192     3     4             249.69            3.33764e+02
HPL_pdgesv() start time Sat Jul 14 14:28:08 2018

HPL_pdgesv() end time   Sat Jul 14 14:32:17 2018

--------------------------------------------------------------------------------
||Ax-b||_oo/(eps*(||A||_oo*||x||_oo+||b||_oo)*N)=        0.0033573 ...... PASSED
================================================================================
```

See [demo_xhpl_intel64_dynamic_outputs.txt](demo_xhpl_intel64_dynamic_outputs.txt) for full output.
