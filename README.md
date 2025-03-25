# About this repository
* Provide research information on data assimilation of satellite observations by [Horinouchi-lab](https://wwwoa.ees.hokudai.ac.jp/people/horinouchi-lab/TC/index.html) in Hokkaido University
* Share numerical simulation codes

## Base system
* **[SCALE-RM](https://scale.riken.jp/ja/scale-rm/)**: forecast model code developed by RIKEN in Kobe
  * [Base version-5.2.6](https://github.com/scale-met/scale/releases/tag/5.2.6)
* **[LETKF](https://github.com/SCALE-LETKF-RIKEN/scale-letkf)**: assimilation code developed by RIKEN in Kobe
  * [Base available for SCALE-RM version-5.2.6](https://github.com/gylien/scale-letkf)

## Updates from the base system
* New observation operators for satellite atmospheric motion vectors proposed by [Tsukada & Horinouchi (2020)](https://doi.org/10.1029/2020GL087637), [Horinouchi et al. (2023)](https://doi.org/10.1175/MWR-D-22-0179.1), and [Tsukada et al. (2024)](https://doi.org/10.1029/2023JD040585).
* Test environment for the [Flow supercomputer system](https://icts.nagoya-u.ac.jp/en/sc/) in Nagoya University

# How to use
1. Build SCALE-RM: Compile `scale-rm` and pre/post processor programs by using codes in `scale-rm/`
    * Please see [the official document for version-5.2.6](https://scale.riken.jp/ja/documents/). 
2. Build LETKF: Compile the assimilation programs by using code in `letkf/`
    * Please see [the original repository](https://github.com/gylien/scale-letkf). 
3. Prepare initial and boundary conditions for ensemble members
4. Run your working directory
    * Also use a template of the working directory in `test_run/`
5. Do analyses
    * ALso use analysis scripts in `ruby_tools/`

<!--
%# Examples
%You can find examples of the configuration and setting file for the CReSS model simulation in `Form/0rig/`. 

%# Documents
%* [Official English Document (Old version)](http://www.rain.hyarc.nagoya-u.ac.jp/~tsuboki/cress_html/src_cress/CReSS2223_users_guide_eng.pdf)
%* [Japanese User's Guide](http://www.rain.hyarc.nagoya-u.ac.jp/~tsuboki/cress_html/from_kato/how_to_use_cress_20110413.pdf)
-->

# References
1. Tsujino, S. and T. Horinouchi, 2025: A Feasibility Study on Objective Analysis of Tropical-Cyclone Intensity Based on Data Assimilation of Inner-Core Atmospheric Motion Vectors. _Journal of Geophysical Research: Atmospheres._ , (submitted). (https://doi.org/10.1007/978-3-031-40567-9_19)
