# GTFS2PTN

``GTFS2PTN`` is a Matlab package for systematically and consistently constructing usable graph representations using the [General Transit Feed Specification (GTFS)](https://developers.google.com/transit/gtfs/) that are suitable for research and education on public transport network, such as topological and spatial analyses.

## Feature

## Documentation
* `loadGTFS`: Load necessary fields from the raw GTFS data into Matlab as a series of tables. The output is used for subsequent functionalitis.
* `buildOperationNetwork`: Build the operation PTN based on the brute-force approach. The input takes the loaded GTFS data from `loadGTFS`, a selected date and a list of route types needed (in line with GTFS, 0-tram, 1-metro, 3-bus).

## Examples
### Amsterdam
The GTFS feed provided by GVB (Amsterdam's local public transport operator) from 2017-11-14 is used as an example. GTFS feed is managed on a daily basis in the Netherlands and can be accessed at http://gtfs.ovapi.nl.



## Authors
Ding Luo (d.luo@tudelft.nl)
