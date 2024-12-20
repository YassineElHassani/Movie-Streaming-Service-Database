-- Name: YASSINE EL HASSANI
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
    releaseYear INT CHECK (releaseYear >= 1000 AND releaseYear <= 3000) NOT NULL,
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

-- Creation of the table Review
USE MovieStreaming;
CREATE TABLE review(
    reviewID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL,
    movieID INT NOT NULL,
    rating INT NOT NULL,
    reviewText TEXT NULL,
    reviewDate DATE NOT NULL
)

-- FOREIGN KEY subscriptionID
ALTER TABLE userinfo 
ADD CONSTRAINT fk_subscriptionID FOREIGN KEY (subscriptionID) REFERENCES subscription(subscriptionID);

-- FOREIGN KEY userID
ALTER TABLE watchHistory
ADD CONSTRAINT fk_userID_watchHistory FOREIGN KEY (userID) REFERENCES userInfo(userID);
ALTER TABLE review
ADD CONSTRAINT fk_userID_review FOREIGN KEY (userID) REFERENCES userInfo(userID);

-- FOREIGN KEY movieID
ALTER TABLE watchHistory
ADD CONSTRAINT fk_movieID_watchHistory FOREIGN KEY (movieID) REFERENCES movie(movieID);
ALTER TABLE review
ADD CONSTRAINT fk_movieID_review FOREIGN KEY (movieID) REFERENCES movie(movieID);

--The requests
-- 1- Insert Movie: Add a new movie titled Data Science Adventures in the genre "Documentary".
INSERT into movie (title, genre, releaseYear, duration, rating) VALUES ('Data Science Adventures', 'Documentary', 2006, 48, 'R');

-- 2- Search Movies: List all movies in the genre "Comedy" released after 2020
SELECT title, releaseYear FROM movie WHERE releaseYear > 2020 AND genre = 'Comedy';

-- 3- Subscriptions Update: Upgrade all users from "Basic" to "Premium".
UPDATE userinfo 
SET subscriptionID = 2 WHERE subscriptionID = 1;

-- 4- Show Subscriptions: Attach users to their subscription types.
SELECT userinfo.firstName, userinfo.lastName, subscription.subscriptionType
FROM userinfo LEFT JOIN subscription ON userinfo.subscriptionID = subscription.subscriptionID;

-- 5- Filter Viewings: Find all users who have finished watching a movie.
SELECT userInfo.firstName, userInfo.lastName, movie.title, watchHistory.watchDATE
FROM watchHistory JOIN userInfo ON watchHistory.userID = userInfo.userID JOIN movie ON watchHistory.movieID = movie.movieID
WHERE watchHistory.completionPercentage = 100;

-- 6- Sort and Limit: Show the 5 longest movies, sorted by duration.
SELECT title AS movieTitle, genre, duration 
FROM movie
ORDER BY duration DESC LIMIT 5


-- 7- Aggregation: Calculate the average completion percentage for each movie.
SELECT movie.title AS movieTitle, AVG(watchhistory.completionPercentage) AS AVG_Percentage
FROM movie 
LEFT JOIN watchhistory ON movie.movieID = watchhistory.movieID
GROUP BY movie.title;

-- 8- Group By: Group users by subscription type and count the total number of users per group.
SELECT COUNT(userinfo.userID) AS totalSubs, subscription.subscriptionType
FROM userinfo
JOIN subscription ON userinfo.subscriptionID = subscription.subscriptionID
GROUP BY subscription.subscriptionType;

-- 9- Subquery (Bonus): Find movies with an average rating above 4.
SELECT movie.movieID, movie.title, (SELECT AVG(review.rating)) AS rating_AVG 
FROM movie JOIN review ON movie.movieID = review.movieID 
GROUP BY movie.movieID, movie.title HAVING rating_AVG > 4;

-- 10- Self-Join (Bonus): Find pairs of movies of the same genre released in the same year.
SELECT m1.title AS movieTitle1, m2.title AS movieTitle2, m1.Genre, m1.ReleaseYear
FROM movie m1
JOIN movie m2 ON  m1.Genre = m2.Genre 
AND m1.ReleaseYear = m2.ReleaseYear AND m1.MovieID < m2.MovieID;