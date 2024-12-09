-- Name: Yassine El hassani
-- Email: jinrox00@gmail.com

-- Creation of the database
CREATE DATABASE movieStreaming;

-- Creation of the table subscription
USE MovieStreaming;
CREATE TABLE subscription(
	subscriptionID INT PRIMARY KEY AUTO_INCREMENT,
    subscriptionType VARCHAR(50) CHECK (subscriptionType IN ('Basic', 'Premium')),
    monthlyFee DECIMAL(10,2)
);