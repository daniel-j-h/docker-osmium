# Docker images for osmium-tool

Pre-built Docker images for [osmium-tool](https://osmcode.org/osmium-tool/) so you don't have to compile it from source.


# Usage

Run via

    docker run danieljh/osmium

Example

    docker run -v ~/osm:/data danieljh/osmium fileinfo /data/berlin-latest.osm.pbf

You can pass "-e OSMIUM_POOL_THREADS=$(nproc)" to control threads used for parsing.


# Building

    docker build -r danieljh/osmium .
