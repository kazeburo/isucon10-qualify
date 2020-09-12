DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;
DROP TABLE IF EXISTS isuumo.estate_feature;
DROP TABLE IF EXISTS isuumo.chair_feature;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL
);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL
);

CREATE TABLE isuumo.estate_feature
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    estate_id   INTEGER         NOT NULL,
    INDEX (estate_id)
);

CREATE TABLE isuumo.chair_feature
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    chair_id    INTEGER         NOT NULL,
    INDEX (chair_id)
);

create index idx_pricestock on isuumo.chair(price asc, stock);
create index idx_pricestockpop on isuumo.chair(price, stock, popularity desc);
create index idx_kindstock on isuumo.chair(kind, stock, popularity desc);
create index idx_color on isuumo.chair(color, stock popularity desc);
create index idx_heistopop on isuumo.chair(height, stock popularity desc);

create index idx_rentpop on isuumo.estate(rent,popularity desc);
create index idx_rent on isuumo.estate(rent asc);
create index idx_door_hei on isuumo.estate(door_height);
create index idx_door_wid on isuumo.estate(door_width);
create index idx_door_widhei on isuumo.estate(door_width, door_height, popularity desc);
create index idx_pop on isuumo.estate(popularity desc);

