using LuxurySparse
using Yao
using LinearAlgebra

eye(n::Int) = IMatrix{n}()

"""
Finding the partition function and ground state degeneracy for
for the classical AF Ising model on Buckyball lattice
TN Exact contraction version 2.0
avoid the complex numbers,
and impurity tensors are used to find the energy value more exactly.
It can be regarded as a quantum circuit with nonunitary gates.
The ground state degeneracy is evaluated by extrapolation
of the number of microstates to zero temperature.
wanghx18@mails.tsinghua.edu.cn, May 8, 2019

The tensor network has 5-fold periodicity,
each of which is in the graph
----------------
  |
----------------
    |       |
----------------
      |   |
----------------
        |
----------------
"""

function blockT(::Val{:Bulk}, beta::Float64)
    x = exp(-beta)
    [x^3 x x 1/x;1/x x 1/x^3 1/x;1/x 1/x^3 x 1/x;1/x x x x^3]
end

function blockT(::Val{:Imp1}, beta::Float64)
    x = exp(-beta)
    [-x^3  -x     x     1/x;
     -1/x  -x     1/x^3 1/x;
     1/x   1/x^3  -x    -1/x;
     1/x   x      -x    -x^3]
end

function blockT(::Val{:Imp2}, beta::Float64)
    x = exp(-beta)
    [-x^3  -x     -x     -1/x;
     1/x   x      1/x^3  1/x;
     1/x   1/x^3  x      1/x;
     -1/x  -x     -x     -x^3]
end

function partition_function(beta::Float64)
    b = blockT(Val(:Bulk), beta)
    tr(mat(tranM(b, b))^5)
end

free_energy(beta::Float64) = -log(partition_function(beta))/60

function tranM(BlockT1::T, BlockT::T) where T<:AbstractMatrix
    G1 = matblock(BlockT1)
    G = matblock(BlockT)
    chain(put(5, (loc, loc+1)=>(loc == 1 ? G1 : G)) for loc in (1,2,3,4,3,2))
end

function IsingOnC60_QC(beta::Float64)
    # free energy at 1K
    F1K = free_energy(beta)
    println("The persite free energy at Temperate 1K is $F1K")
    # finite temperature calculation
    Beta=8:.3:12

    F=zeros(size(Beta)...)
    E=zeros(size(Beta)...)
    S=zeros(size(Beta)...)
    for (j, beta) in enumerate(Beta)
        x=exp(-beta)
        BlockT = blockT(Val(:Bulk), beta)
        TranM = tranM(BlockT, BlockT) |> mat

        # There are two impurity class
        BlockT_impurity1 = blockT(Val(:Imp1), beta)
        # the first class impurity, i.e. the impurity boltzmann weight on the edge of pentagon.
        TranM_impurity1 = tranM(BlockT_impurity1, BlockT) |> mat

        # the second class impurity, i.e. the otherwise cases.
        BlockT_impurity2 = blockT(Val(:Imp2), beta)
        TranM_impurity2 = tranM(BlockT_impurity2, BlockT) |> mat


        Z=tr(TranM^5)
        Z1=tr(TranM^4*TranM_impurity1)
        Z2=tr(TranM^4*TranM_impurity2)
        F[j]=-log(Z)/beta
        E[j]=-(60*Z1+30*Z2)/Z
        S[j]=log(Z)-beta*(60*Z1+30*Z2)/Z
    end
    println("The ground state degeneracy is about $(floor(exp(S[5])))")
    F, E, S
end

F, E, S = IsingOnC60_QC(1.0)
