# Postgres Source

First: put some data into postgres source

```
psql -U postgres

CREATE TABLE customers (id TEXT PRIMARY KEY, name TEXT, age INT);
INSERT INTO customers (id, name, age) VALUES ('5', 'fred', 34);
INSERT INTO customers (id, name, age) VALUES ('7', 'sue', 25);
INSERT INTO customers (id, name, age) VALUES ('2', 'bill', 51);
```

# Source connector

Execute the send.sh script to run the source connector

# KSQL

Run these command in the cli

```
ksql http://ksqldb-server:8088

set 'commit.interval.ms'='0';
set 'cache.max.bytes.buffering'='10000000';
set 'auto.offset.reset'='earliest';

CREATE STREAM customers WITH (
    kafka_topic = 'customers.public.customers',
    value_format = 'avro'
);

CREATE OR REPLACE STREAM take_ids WITH (
    kafka_topic = 'take_ids',
    VALUE_FORMAT='AVRO'
)   AS
    SELECT o.id as "id", o.name as "name"
    FROM customers AS o
    EMIT CHANGES;
```

# Sink connector

Execute the sink.sh script to run the sink connector
Go into postgres sink and verify that data is present;

```
psql -U postgres
\dt
```

you can also verify the state of the sink connector

```
SHOW CONNECTORS;
DESCRIBE CONNECTOR "pgsink";
```

# Useful commands

```
DROP STREAM [IF EXISTS] <stream_name> [DELETE TOPIC];
TERMINATE <query>;
```

# Notes

- In order to restart a connector, just remove the old one and rename it (https://stackoverflow.com/questions/55377441/restart-kafka-connect-sink-and-source-connectors-to-read-from-beginning)
- Tombstones must be absent in the stream or sink connector will not work

# TODO

- At the moment, delete is not reflected; make tombstones readable by the stream and then delete the old rows with delete.enabled="true"
