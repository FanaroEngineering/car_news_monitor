# Run this from the top-most context of `fanaroEngineering`:
# ```sh
# docker build -f packages/domain/servers/car_news_server/Dockerfile -t car-news-monitor .
# ```

FROM ubuntu:latest

ENV pkgs="packages"
ENV domain="$pkgs/domain"
ENV test_utils="$pkgs/test_utils"
ENV servers="$domain/servers"
ENV entities="$domain/entities"
ENV scrapers="$domain/scrapers"

ENV FLUTTER_GITHUB="https://github.com/flutter/flutter.git"
ENV FLUTTER="/flutter/bin/flutter"

ADD /${servers}/car_news_server /${servers}/car_news_server
ADD /${entities}/car_news_entities /${entities}/car_news_entities
ADD /${scrapers}/car_news_scraper /${scrapers}/car_news_scraper
ADD /${test_utils}/path_utils /${test_utils}/path_utils

ARG car_news_server="/packages/domain/servers/car_news_server"

RUN apt update
RUN apt install -y git curl unzip
RUN git clone ${FLUTTER_GITHUB} -b stable
RUN ${FLUTTER} doctor
RUN cd ${car_news_server} && ${FLUTTER} pub get
RUN cd ${car_news_server} && ${FLUTTER} pub get --offline

WORKDIR /packages/domain/servers/car_news_server

ENTRYPOINT ["/flutter/bin/cache/dart-sdk/bin/dart", "bin/car_news_server.dart"]