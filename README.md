# Matrix Compression using Log-Det heuristic, with application in dynamic systems identification.

## Summary

The purpose of the thesis was to examine the effectiveness of the proposed new method of determining the implementation of a dynamic system and reducing its order based on noisy inputoutput signals. In the absence of noises, the order of the Hankel matrix of a sufficiently high rank is equal to the order of implementation of the minimum identified system, while the situation becomes more complicated in the presence of measuring noise (always present in real problems), when the Hankel matrix is full order, regardless of its rank. Standard implementation is determined by reducing the Hankel matrix order by getting rid of the least significant singular values, and then conducting the ERA (Eigenrealization Algorithm) implementation procedure. The work proposes a new approach based on the reduction of the Hankel matrix order using an appropriate optimization procedure. This approach is a form of pre-processing of the Hankel matrix before using the ERA procedure, in the paper it has been called the hybrid method. The proposed method was compared with existing methods, demonstrating by means of appropriate simulations its better performance for the examined cases.

