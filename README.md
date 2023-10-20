# fractionizer-vlang
Numbers in the range [0.005, 1] as a sum of 2, 3, 4 or 5 unit fractions of special types.

# Mathematical problem solution

Let's consider the problem of decomposition (approximation) of fractions
that lie in the range [0.005, 2/3)  by the sum of two fractions with 1 in
the numerators (so called unit fractions) and, possibly, natural,
unequal numbers in the denominators.

We will consider one of the two denominators to be a natural number,
smaller than the other number in the denominator, and we will look for
such a pair of numbers that, when rounded to natural numbers, will give
the minimum absolute error of the resulting approximation.
Mathematically, this leads to a problem and its further solution below.

Finally, we can decompose (approximate) the fraction in the range [0.005, 1] 
by the sum of 2, 3, 4, 5 or more unit fractions, with likely different denominators, 
just as like in the Egyptian mathematics.

In relation to music, this means that we can create rhythmic patterns using these 
unit fractions by treating the 1 as the music bar (notes between two consequtive barlines), 
but this leads to patterns that use irrational (non-dyadic) music meters and together to 
slightly different (hopefully, not perceptible) from 1 summary duration.

The tests show that there are some numerical instability for the numbers with more digits 
after the dot. So we use just 3 digits as correct after the dot, but the errors are 
calculated with respect to the original value with all the digits included.

More is by the link in the package description.

# Relation to music rhythm and meter 

It can be used to produce music by approximation of the meter. 
This leads to interesting structures.

It also is directly connected to the irrational time signatures in music.

# Acknowledgements

Author would like to support the foundation
[Gastrostars](https://gastrostars.nl) and its founder [Emma Kok](https://emmakok.nl). 
The founder inspired him to conduct such a research. 
Besides, the author is grateful to the [Hackage website](https://hackage.haskell.org) 
for publishing the Haskell code related to the research.

If you would like to share some financial support with the Foundation Gastrostars, please, contact the mentioned foundation
using the URL:

[Contact Foundation GASTROSTARS](https://gastrostars.nl/hou-mij-op-de-hoogte)

or 

[Donation Page](https://gastrostars.nl/doneren)
