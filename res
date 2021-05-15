================================================================================
HPLinpack 2.3  --  High-Performance Linpack benchmark  --   December 2, 2018
Written by A. Petitet and R. Clint Whaley,  Innovative Computing Laboratory, UTK
Modified by Piotr Luszczek, Innovative Computing Laboratory, UTK
Modified by Julien Langou, University of Colorado Denver
================================================================================

An explanation of the input/output parameters follows:
T/V    : Wall time / encoded variant.
N      : The order of the coefficient matrix A.
NB     : The partitioning blocking factor.
P      : The number of process rows.
Q      : The number of process columns.
Time   : Time in seconds to solve the linear system.
Gflops : Rate of execution for solving the linear system.

The following parameter values will be used:

N      :      29       30       34       35 
NB     :       1        2        3        4 
PMAP   : Row-major process mapping
P      :       2        1        4 
Q      :       2        4        1 
PFACT  :    Left    Crout    Right 
NBMIN  :       2        4 
NDIV   :       2 
RFACT  :    Left    Crout    Right 
BCAST  :   1ring 
DEPTH  :       0 
SWAP   : Mix (threshold = 64)
L1     : transposed form
U      : transposed form
EQUIL  : yes
ALIGN  : 8 double precision words

--------------------------------------------------------------------------------

- The matrix A is randomly generated for each test.
- The following scaled residual check will be computed:
      ||Ax-b||_oo / ( eps * ( || x ||_oo * || A ||_oo + || b ||_oo ) * N )
- The relative machine precision (eps) is taken to be               1.110223e-16
- Computational tests pass if scaled residuals are less than                16.0

================================================================================
T/V                N    NB     P     Q               Time                 Gflops
--------------------------------------------------------------------------------
WR00L2L2          29     1     2     2               3.79             4.6178e-06
HPL_pdgesv() start time Sat May 15 18:05:59 2021

HPL_pdgesv() end time   Sat May 15 18:06:03 2021

--------------------------------------------------------------------------------
||Ax-b||_oo/(eps*(||A||_oo*||x||_oo+||b||_oo)*N)=   1.72533487e-02 ...... PASSED
================================================================================
T/V                N    NB     P     Q               Time                 Gflops
--------------------------------------------------------------------------------
WR00L2L4          29     1     2     2               3.92             4.4728e-06
HPL_pdgesv() start time Sat May 15 18:06:03 2021

HPL_pdgesv() end time   Sat May 15 18:06:07 2021

--------------------------------------------------------------------------------
||Ax-b||_oo/(eps*(||A||_oo*||x||_oo+||b||_oo)*N)=   1.72533487e-02 ...... PASSED
================================================================================
T/V                N    NB     P     Q               Time                 Gflops
--------------------------------------------------------------------------------
WR00L2C2          29     1     2     2               4.45             3.9376e-06
HPL_pdgesv() start time Sat May 15 18:06:07 2021

HPL_pdgesv() end time   Sat May 15 18:06:11 2021

--------------------------------------------------------------------------------
||Ax-b||_oo/(eps*(||A||_oo*||x||_oo+||b||_oo)*N)=   1.72533487e-02 ...... PASSED
[mpiexec@archlinux] Sending Ctrl-C to processes as requested
[mpiexec@archlinux] Press Ctrl-C again to force abort

===================================================================================
=   BAD TERMINATION OF ONE OF YOUR APPLICATION PROCESSES
=   PID 2451 RUNNING AT archlinux
=   EXIT CODE: 2
=   CLEANING UP REMAINING PROCESSES
=   YOU CAN IGNORE THE BELOW CLEANUP MESSAGES
===================================================================================
YOUR APPLICATION TERMINATED WITH THE EXIT STRING: Interrupt (signal 2)
This typically refers to a problem with your application.
Please see the FAQ page for debugging suggestions
