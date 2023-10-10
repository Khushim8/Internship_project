DROP TABLE IF EXISTS Main;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS ways;


CREATE TABLE city (
    c_id INT NOT NULL PRIMARY KEY, 
    c_name VARCHAR(200) NOT NULL
);


INSERT INTO city (c_id, c_name) VALUES 
(1, 'Mumbai'),
(2, 'Pune'),
(3, 'Delhi'),
(4, 'Kolkata'),
(5, 'Chennai'),
(6, 'Hyderabad'),
(7, 'Banglore'),
(8, 'Shrinagar'),
(9, 'Jaipur'),
(10, 'Amritsar');



CREATE TABLE Ways (
  Ways_ID INT PRIMARY KEY,
  type TEXT NOT NULL
);



INSERT INTO Ways(Ways_ID, type) VALUES 
(1, 'Air'),
(2, 'Car'),
(3, 'Water'),
(4, 'Rails');


CREATE TABLE newmain (
    route_id SERIAL PRIMARY KEY,
    From_City_ID INT NOT NULL,
    To_City_ID INT NOT NULL,
    intermediate_cities INT[],
    way_id INT NOT NULL,
    cost NUMERIC(10, 2),  
    distance NUMERIC(10, 2),  
    Time INT,  
    FOREIGN KEY (From_City_ID) REFERENCES city(c_id),
    FOREIGN KEY (To_City_ID) REFERENCES city(c_id),
    FOREIGN KEY (way_id) REFERENCES Ways(Ways_ID)
);


INSERT INTO newmain (From_City_ID, To_City_ID, intermediate_cities, way_id, cost, distance, Time)
SELECT
    c1.c_id AS From_City_ID,
    c2.c_id AS To_City_ID,
    ARRAY[inter.c_id, inter2.c_id] AS intermediate_cities, 
    w.Ways_ID AS way_id,
    RANDOM() * 500 + 50 AS cost,  
    RANDOM() * 1500 + 500 AS distance,  
    random_travel_time() AS Time  
FROM city c1
CROSS JOIN city c2
CROSS JOIN Ways w
LEFT JOIN city inter ON c1.c_id != c2.c_id AND c1.c_id != inter.c_id AND c2.c_id != inter.c_id
LEFT JOIN city inter2 ON c1.c_id != c2.c_id AND c1.c_id != inter2.c_id AND c2.c_id != inter2.c_id AND inter.c_id != inter2.c_id;


UPDATE newmain SET distance = ROUND(RAND() * 500, 2);
UPDATE newmain SET cost = ROUND(RAND() * 400, 2);
UPDATE newmain SET Time = HOUR(Time) * 60 + MINUTE(Time);
UPDATE newmain SET Time = ROUND(RAND() * 3000, 2);
