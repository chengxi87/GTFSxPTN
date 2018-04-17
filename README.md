# GTFS2PTN

``GTFS2PTN`` is a Matlab tool for constructing a number of Public Transport Network (PTN) representations on different scales and different topological forms using the [General Transit Feed Specification (GTFS)](https://developers.google.com/transit/gtfs/). The tool is aimed for research and education on PTNs, such as topological and spatial analyses. 

## Feature

## Documentation
* `loadGTFS`: Load necessary fields from the raw GTFS data into Matlab as a series of tables. The output is used for subsequent functionalitis.
* `buildBsPTN`: Build the Bottom-scale PTN using a brute-force approach. The input takes the loaded GTFS data from `loadGTFS`, a selected date and a list of route types needed (in line with GTFS, 0-tram, 1-metro, 2-rail, 3-bus).
* `buildMsPTN`: Build the Middle-scale PTN based on the bottom-scale PTN. The key part is the merging of PT stops. 



## Examples
### Amsterdam
The GTFS feed provided by GVB (Amsterdam's local public transport operator) from 2017-11-14 is used as an example. GTFS feed is managed on a daily basis in the Netherlands and can be accessed at http://gtfs.ovapi.nl.



## Authors
Ding Luo (d.luo@tudelft.nl)
