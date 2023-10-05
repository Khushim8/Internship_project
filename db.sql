

 --------------------------------------------------------
CREATE TABLE city (
    c_id INT NOT NULL,
    c_name VARCHAR(200) NOT NULL
);
INSERT INTO city (c_id,c_name) VALUES 
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
INSERT INTO Ways (Ways_ID, type) VALUES 
    (1, 'Air'),
    (2, 'Car'),
    (3, 'Water'),
    (4, 'Rails');
--------------------------------------------------------

CREATE TABLE Main (
    Id INT PRIMARY KEY,
    Way_ID INT,
    From_City_ID INT,
    To_City_ID INT,
    Distance DECIMAL(10, 2),
    Cost DECIMAL(10, 2),
    Time INT,
    Random VARCHAR(255),
    FOREIGN KEY (Way_ID) REFERENCES Ways(Ways_ID),
    FOREIGN KEY (From_City_ID) REFERENCES City(c_id),
    FOREIGN KEY (To_City_ID) REFERENCES City(c_id)
);
INSERT INTO Main (Way_ID, From_City_ID, To_City_ID, Distance, Cost, Time, Random)
SELECT w.Ways_Id AS Way_Id, c.c_id AS From_City_Id, c2.c_id AS To_City_Id, 0.00, 0.00, 0, 'Random'
FROM City c 
CROSS JOIN Ways w 
CROSS JOIN City c2;

UPDATE main SET Distance = ROUND(RAND() * 500, 2);
UPDATE main SET Cost = ROUND(RAND() * 400, 2);
UPDATE main SET Time = HOUR(Time) * 60 + MINUTE(Time);
UPDATE main SET Time = ROUND(RAND() * 3000, 2);

