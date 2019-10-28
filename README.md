# treatment-exposure-sensitivity-model

This repository contains code to run the model simulations in Massey, et al. "Quantifying glioblastoma drug response dynamics incorporating resistance and blood brain barrier penetrance from experimental data." (currently under review, preprint available on bioRxiv doi link here)

This brain tumor growth and treatment model incorporates blood-brain barrier effects on overall drug distribution in the tumor as well as treatment sensitive and insensitive tumor subpopulations. The model consists of a system of three ordinary differential equations with analytical solution: 
<img src="/tex/6c581f097a0bca97e014d06c46c02fa7.svg?invert_in_darkmode&sanitize=true" align=middle width=381.05650769999994pt height=37.80850590000001pt/>,
where
<img src="/tex/2c02f80ccbe700cc7a2e5771b1cbd758.svg?invert_in_darkmode&sanitize=true" align=middle width=321.91359255000003pt height=43.068412200000004pt/>
which is used in BLImodel.m to generate simulation results for different parameter values when called by SimsExploringParameterSpace.m Simulation results across a range of parameters are plotted as heatmaps at a single time point using SimSubplots.m

Further model development details, parameter defitions, and analysis of results are provided in the manuscript, along with analysis of the results. For details on parameter sensitivity analysis, see the repository [model-sensitivity-analysis](https://github.com/scmassey/model-sensitivity-analysis). 
# treatment-exposure-sensitivity-model
