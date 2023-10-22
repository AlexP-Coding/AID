
DROP DATABASE IF EXISTS redes_dw;

CREATE DATABASE redes_dw;

USE redes_dw;

CREATE TABLE dim_time (
    TIME_ID INT AUTO_INCREMENT,
    DATE_ID DATE,
    YEAR_ID INT,
    MONTH_ID INT,
    MONTH_NAME VARCHAR(255),
    PRIMARY KEY (TIME_ID)
);

CREATE TABLE dim_location (
	LOCATION_ID INT,
	PARISH_NAME VARCHAR(255),
	PARISH_CODE VARCHAR(255),
	MUNICIPALITY_NAME VARCHAR(255),
	MUNICIPALITY_CODE INT,
	DISTRICT_NAME VARCHAR(255),
	DISTRICT_CODE INT,
	VERSION INT,
    DATE_FROM DATETIME,
    DATE_TO DATETIME,
	PRIMARY KEY (LOCATION_ID)
);

CREATE TABLE dim_voltage (
	VOLTAGE_ID INT AUTO_INCREMENT,
	VOLTAGE_NAME VARCHAR(255),
	PRIMARY KEY (VOLTAGE_ID)
);

CREATE TABLE fact_consumption (
	TIME_ID INT,
	LOCATION_ID INT,
	VOLTAGE_ID INT,
	ENERGYCONSUMPTION DOUBLE,
	PRIMARY KEY (TIME_ID, LOCATION_ID, VOLTAGE_ID),
    FOREIGN KEY (TIME_ID) REFERENCES dim_time (TIME_ID),
    FOREIGN KEY (LOCATION_ID) REFERENCES dim_location (LOCATION_ID),
    FOREIGN KEY (VOLTAGE_ID) REFERENCES dim_voltage (VOLTAGE_ID)
);