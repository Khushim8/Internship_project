

 --------------------------------------------------------
CREATE TABLE 'CITY' 
(
    'City_ID' INT NOT NULL,
    'City' VARCHAR(200) NOT NULL
);

INSERT INTO 'CITY' ('ID','City') VALUES 
('101','Mumbai'),
('102','Pune'),
('103','Delhi'),
('104','Kolkata'),
('105','Chennai'),
('106','Hyderabad'),
('107','Banglore'),
('108','Shrinagar'),
('109','Jaipur'),
('110','Amritsar');

--------------------------------------------------------

CREATE TABLE 'Ways' (
  'Ways_ID' INTEGER PRIMARY KEY,
  'type' TEXT NOT NULL
);
-- insert some values
INSERT INTO 'Ways' VALUES 
(201, 'Air'),
(202 , 'Car'),
(203, 'Water'),
(204 ,'Rails');

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
 (301,201,101,102,540,50,240,1),
 (302,202,101,102,530,100,150,1), 
 (303,203,101,102,234,100,345,1), 
 (304,204,101,102,567,345,235,1);
