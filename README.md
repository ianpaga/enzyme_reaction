Enzyme reaction in the presence of molecules A and B in three dimensions
====

Description: The main code ProjectENZYME.m computes the time evolution of the number of enzymes ($E$) and molecules $A$ and $B$. 
The [Michaelis-Menten equation](https://en.wikibooks.org/wiki/Structural_Biochemistry/Enzyme/Michaelis_and_Menten_Equation#:~:text=The%20Michaelis%2DMenten%20equation%20arises,and%20P%20is%20the%20product.) arises from the general equation for an enzymatic reaction: $E + S \longleftrightarrow ES \longleftrightarrow E + P$, where $E$ is the enzyme, $S$ is the substrate, $ES$ is the enzyme-substrate complex, and $P$ is the product. Thus, the enzyme combines with the substrate in order to form the $ES$ complex, which in turn converts to product while preserving the enzyme. 

In our language this means that the reactions computed are of the form:

$E + A \longleftrightarrow EA \longleftrightarrow E + B$

Note that the reactions go in both directions and that the number of enzymes stays constant in time.

## Figures:

![setupVW](https://github.com/ianpaga/enzyme_reaction/assets/57350668/1fdb6975-cc80-47d8-b639-a8dee480bd37)
![3DEnzyme](https://github.com/ianpaga/enzyme_reaction/assets/57350668/518757ab-1868-4d3a-8327-3c8eae80c80d)
![3DABC](https://github.com/ianpaga/enzyme_reaction/assets/57350668/b0d0a978-947b-4c22-918a-b62974688e87)

## Requirements:

- MATLAB (version 2017 or later)

  Running this ProjectENZYME.m computes (MATLAB) code will generate plots in /plots. You can also run the simpler ProjectABC.m file to understand
  the time evolution of the numbers of molecules type $A, B$ and $C$ as they undergo the reaction $A + B \rightarrow C$.
