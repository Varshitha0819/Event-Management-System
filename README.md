# Event Management System

## Introduction

The **Event Management System** is a comprehensive solution designed to streamline the process of planning, organizing, and managing events. This system allows event organizers to handle various aspects of an event, such as venue management, attendee registration, resource allocation, and RSVP tracking. Built with a relational database and SQL, this system aims to eliminate the challenges associated with manual event planning and provide a user-friendly interface for event managers.

This system is highly flexible and scalable, capable of handling a wide range of events, from small conferences to large-scale corporate gatherings.

## Abstract

The **Event Management System** provides a centralized platform for event organizers to manage all aspects of an event. The system includes features for creating and managing events, assigning venues and resources, tracking RSVPs from attendees, and ensuring resource availability. The database is designed to handle multiple events, multiple attendees, and multiple resources efficiently, ensuring data integrity and quick access to relevant information. 

With the increasing complexity of event management, the system aims to automate the process and improve decision-making by providing clear data insights into event performance, attendee behavior, and resource utilization.

## Features/Functionalities

- **Event Creation & Management**: Create, update, and delete events with basic details such as event name, date, time, and venue.
- **Venue Management**: Define venues for events, manage their availability, and link them to specific events.
- **Attendee Management**: Register attendees for events, track RSVP statuses (Accepted, Pending, Declined), and maintain attendee details.
- **Resource Allocation**: Track resources (e.g., projectors, chairs, tables) needed for events and manage their availability.
- **RSVP Tracking**: Allow attendees to RSVP for events and manage their participation status.
- **Data Integrity**: Ensure consistent and accurate data with relational database design, including foreign key constraints and relational integrity.
- **Scalability**: The system can handle multiple events, attendees, and resources, making it adaptable for events of any size.

## Database Design

### Schema Overview

The Event Management System’s database is structured into several key entities, each representing a core component of the event management process. These entities include **Event**, **Venue**, **Attendee**, **RSVP**, and **Resource**, each connected by various relationships that reflect the real-world interactions between these components.

The core tables in the database are:

- **Event**
- **Venue**
- **Attendee**
- **RSVP**
- **Resource**

### Tables and Relationships

The following outlines the tables and relationships in the Event Management System:

1. **Event Table**: Stores details about each event.
2. **Venue Table**: Stores venue information such as name, location, and capacity.
3. **Attendee Table**: Contains information about attendees, such as their name and email.
4. **RSVP Table**: Links attendees with events and tracks the RSVP status.
5. **Resource Table**: Keeps track of resources needed for events (e.g., projectors, microphones).
6. **Event_Resource Table**: Manages the many-to-many relationship between events and resources.

## Implementation Details

### Table Creation Script

The following SQL script is used to create the database schema for the Event Management System:

```sql
CREATE DATABASE EventManagement;

USE EventManagement;

CREATE TABLE Venue (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE Event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    venue_id INT,
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
);

CREATE TABLE Attendee (
    attendee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE RSVP (
    rsvp_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    attendee_id INT,
    status ENUM('Accepted', 'Pending', 'Declined') NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Event(event_id),
    FOREIGN KEY (attendee_id) REFERENCES Attendee(attendee_id)
);

CREATE TABLE Resource (
    resource_id INT AUTO_INCREMENT PRIMARY KEY,
    resource_name VARCHAR(255) NOT NULL,
    availability BOOLEAN NOT NULL
);

CREATE TABLE Event_Resource (
    event_resource_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    resource_id INT,
    FOREIGN KEY (event_id) REFERENCES Event(event_id),
    FOREIGN KEY (resource_id) REFERENCES Resource(resource_id)
);
