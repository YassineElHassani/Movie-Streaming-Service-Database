-- Name: Yassine El hassani
-- Email: jinrox00@gmail.com

-- Creation of the database
CREATE DATABASE movieStreaming;

-- Creation of the table subscription
USE MovieStreaming;
CREATE TABLE subscription(
	subscriptionID INT PRIMARY KEY AUTO_INCREMENT,
    subscriptionType VARCHAR(50) CHECK (subscriptionType IN ('Basic', 'Premium')),
    monthlyFee DECIMAL(10,2) NOT NULL
);

-- Creation of the table UserInfo
USE MovieStreaming;
CREATE TABLE userInfo(
	userID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration DATE NOT NULL,
    subscriptionID INT NOT NULL
);

-- Creation of the table Movie
USE MovieStreaming;
CREATE TABLE movie(
	movieID INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    releaseYear INT NOT NULL,
    duration INT NOT NULL,
    rating VARCHAR(10) NOT NULL
);

-- Creation of the table watchHistory
USE MovieStreaming;
CREATE TABLE watchHistory(
	watchHistoryID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL,
    movieID INT NOT NULL,
    watchDATE DATE NOT NULL,
    completionPercentage INT DEFAULT 0
);