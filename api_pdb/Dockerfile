FROM ruby:3.0.1-alpine

ARG USER_ID
ARG GROUP_ID

RUN addgroup -g $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID -G user user

ENV RAILS_ROOT /api_pdb
ENV BUNDLE_VERSION 2.1.4

COPY ./docker/dev-entrypoint.sh /usr/local/bin/dev-entrypoint.sh
RUN chmod +x /usr/local/bin/dev-entrypoint.sh

RUN apk add --update --no-cache \
      build-base \
      git \
      postgresql-dev \
      postgresql-client \
      libxml2-dev \
      libxslt-dev \
      nodejs \
      yarn \
      imagemagick \
      tzdata \
      less \
      nano \
      shared-mime-info \
      && mkdir -p $RAILS_ROOT

RUN cp /usr/share/zoneinfo/America/Fortaleza /etc/localtime
RUN echo "America/Fortaleza" >  /etc/timezone

RUN gem install bundler --version "$BUNDLE_VERSION" \
&& rm -rf $GEM_HOME/cache/*

WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock $RAILS_ROOT/
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install --jobs 20 --retry 5

COPY . $RAILS_ROOT/

RUN chown -R user:user $RAILS_ROOT/ && chmod a+rwx -R $RAILS_ROOT/ 

USER $USER_ID
