USE event_management;

CREATE TABLE Venues (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    organizer VARCHAR(100),
    date DATE NOT NULL,
    time TIME NOT NULL,
    venue_id INT,
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
);

CREATE TABLE Attendees (
    attendee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE RSVPs (
    rsvp_id INT AUTO_INCREMENT PRIMARY KEY,
    attendee_id INT,
    event_id INT,
    status ENUM('Accepted', 'Declined') NOT NULL,
    FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE Resources (
    resource_id INT AUTO_INCREMENT PRIMARY KEY,
    resource_name VARCHAR(100) NOT NULL,
    availability ENUM('Available', 'Unavailable') DEFAULT 'Available'
);

CREATE TABLE Event_Resources (
    event_id INT,
    resource_id INT,
    PRIMARY KEY (event_id, resource_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (resource_id) REFERENCES Resources(resource_id)
);


INSERT INTO Venues (name, capacity)
VALUES
('Grand Hall', 200),
('Conference Room', 50),
('Open Garden', 300);

INSERT INTO Events (event_name, organizer, date, time, venue_id)
VALUES
('Tech Conference', 'John Doe', '2025-02-10', '10:00:00', 1),
('Wedding Celebration', 'Jane Smith', '2025-02-11', '15:00:00', 3),
('Startup Pitch Fest', 'Startup Hub', '2025-02-10', '12:00:00', 2);

INSERT INTO Attendees (name, email)
VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com');

INSERT INTO RSVPs (attendee_id, event_id, status)
VALUES
(1, 1, 'Accepted'),
(2, 1, 'Accepted'),
(3, 2, 'Accepted'),
(1, 3, 'Declined');

INSERT INTO Resources (resource_name, availability)
VALUES
('Projector', 'Available'),
('Sound System', 'Available'),
('Chairs', 'Available'),
('Stage Setup', 'Unavailable');

INSERT INTO Event_Resources (event_id, resource_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

SELECT * FROM Venues;
SELECT * FROM Events;
SELECT * FROM Attendees;
SELECT * FROM RSVPs;
SELECT * FROM Resources;
SELECT * FROM Event_Resources;


-- Some important queries
SELECT 
    e.event_id,
    e.event_name,
    e.organizer,
    e.date,
    e.time,
    v.name AS venue_name,
    v.capacity
FROM 
    Events e
JOIN 
    Venues v ON e.venue_id = v.venue_id;

-- Find Overlapping Events at the Same Venue
SELECT 
    e1.event_name AS event_1,
    e2.event_name AS event_2,
    v.name AS venue_name,
    e1.date
FROM 
    Events e1
JOIN 
    Events e2 ON e1.venue_id = e2.venue_id 
             AND e1.date = e2.date 
             AND e1.time < ADDTIME(e2.time, '02:00:00') 
             AND e2.time < ADDTIME(e1.time, '02:00:00')
JOIN 
    Venues v ON e1.venue_id = v.venue_id
WHERE 
    e1.event_id < e2.event_id;

-- Check Attendance for an Event
SELECT 
    a.name AS attendee_name,
    a.email,
    r.status
FROM 
    RSVPs r
JOIN 
    Attendees a ON r.attendee_id = a.attendee_id
WHERE 
    r.event_id = 1; -- Replace 1 with the event_id of your choice































