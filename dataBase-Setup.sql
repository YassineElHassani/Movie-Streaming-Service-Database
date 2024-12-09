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

-- Creation of the table UserInfo
USE MovieStreaming;
CREATE TABLE userInfo(
	userID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    registration DATE,
    subscriptionID INT
);