

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
INSERT into 'Main' values
 (1,1,1,2,540,50,240,1),
 (2,2,1,2,530,100,150,1), 
 (3,3,1,2,234,100,345,1), 
 (4,4,1,2,567,345,235,1);
