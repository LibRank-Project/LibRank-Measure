# LibRank::Measure

This repository contains implementations for some common IR performance measures.
The implemented measures are:

* (Discounted) Cumulative Gain (CG/DCG) + normalized version (nCG/nDCG)
* Expected Reciprocal Rank (ERR) + normalized version (nERR)
* Precision (at k)

`LibRank::Measure::Func` contains the functional implementation of the measures.
There are also object oriented implementations that primarily aim for high performance
in batch settings. For every search task one measure object needs to be created, 
which then caches e.g. the calculation of discount values or the maximal score (for 
the normalized measures). `LibRank::Measure::Scorer` is a simple container for 
multiple measures.
