# treatment-exposure-sensitivity-model

This repository contains code to run the model simulations in Massey, et al. "Quantifying glioblastoma drug response dynamics incorporating resistance and blood brain barrier penetrance from experimental data." (currently under review, preprint available on bioRxiv doi link here)

This brain tumor growth and treatment model incorporates blood-brain barrier effects on overall drug distribution in the tumor as well as treatment sensitive and insensitive tumor subpopulations. The model consists of a system of three ordinary differential equations with analytical solution: 
$ C(t)=C_0 e^{\rho t} \left(qe^{-\gamma z \mu_s \int A(t)dt} +(1-q)e^{-\gamma \mu_s \int A(t)dt} \right)$,
where
$\int A(t)dt = \sum_{n=1}^N 2^n A_{\text{dose}} (n) \frac{\left(e^{7 n \lambda} - e^{\lambda t}\right) \theta(t-7n)}{\lambda}$
which is used in BLImodel.m to generate simulation results for different parameter values when called by SimsExploringParameterSpace.m Simulation results across a range of parameters are plotted as heatmaps at a single time point using SimSubplots.m

Further model development details, parameter defitions, and analysis of results are provided in the manuscript, along with analysis of the results. For details on parameter sensitivity analysis, see the repository [model-sensitivity-analysis](https://github.com/scmassey/model-sensitivity-analysis). 
# treatment-exposure-sensitivity-model
