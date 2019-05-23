FROM ubuntu:18.04 as build
WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y wget unzip g++ cmake make libexpat1-dev zlib1g-dev libbz2-dev libboost-dev libboost-program-options-dev
RUN wget https://github.com/mapbox/protozero/archive/fadd024d49f72240bc43548907d51c2b0f2eaeca.zip     && \
    wget https://github.com/osmcode/libosmium/archive/5c06fbb607253a9989929f864811a129a9d5e49b.zip    && \
    wget https://github.com/osmcode/osmium-tool/archive/7b48223f8fe6305dd2fd15d65c90207ae9a889b4.zip  && \
    for f in *.zip; do unzip $f && rm $f; done                                                        && \
    mv protozero* protozero && mv libosmium* libosmium && mv osmium-tool* osmium-tool                 && \
    mkdir osmium-tool/build && cd osmium-tool/build                                                   && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && make -j$(nproc) && make install

FROM ubuntu:18.04 as runtime
RUN apt-get update && apt-get install -y libexpat1 libboost-program-options1.65.1
COPY --from=build /usr/local/bin/osmium /usr/local/bin/osmium
ENTRYPOINT ["osmium"]
CMD ["--help"]
