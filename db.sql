

 --------------------------------------------------------
CREATE TABLE 'CITY' 
(
    'City_ID' INT NOT NULL,
    'City' VARCHAR(200) NOT NULL
);

INSERT INTO 'CITY' ('ID','City') VALUES 
('1','Mumbai'),
('2','Pune'),
('3','Delhi'),
('4','Kolkata'),
('5','Chennai'),
('6','Hyderabad'),
('7','Banglore'),
('8','Shrinagar'),
('9','Jaipur'),
('10','Amritsar');

--------------------------------------------------------

CREATE TABLE 'Ways' (
  'Ways_ID' INTEGER PRIMARY KEY,
  'type' TEXT NOT NULL
);
-- insert some values
INSERT INTO 'Ways' VALUES 
(1, 'Air'),
(2 , 'Car'),
(3, 'Water'),
(4 ,'Rails');

--------------------------------------------------------

CREATE TABLE 'Main' (
    Id INT PRIMARY KEY,
    Way_ID INT,
    From_City_ID INT,
    To_City_ID INT,
    Distance DECIMAL(10, 2), -- You can adjust the precision and scale based on your needs
    Cost DECIMAL(10, 2),
    Time INT,
    Random VARCHAR(255),
    FOREIGN KEY (Way_ID) REFERENCES Ways(Ways_ID),
    FOREIGN KEY (From_City_ID) REFERENCES City(City_ID),
    FOREIGN KEY (To_City_ID) REFERENCES City(City_ID)
);

SELECT c.City_Id AS From_City_Id,w.Ways_Id AS Way_Id,c2.City_Id AS To_City_Id FROM City c CROSS JOIN Ways w CROSS JOIN City c2;
