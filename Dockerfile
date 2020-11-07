FROM confluentinc/cp-kafka-connect-base:6.0.0

RUN    confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:latest \
    && confluent-hub install --no-prompt debezium/debezium-connector-postgresql:latest

# based on:
# https://docs.confluent.io/current/connect/managing/extending.html

# list of connectors:
# https://docs.confluent.io/current/connect/managing/connectors.html