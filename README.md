# 🎵 Music Store Database Project
## 📌 Project Overview
This project demonstrates how to analyze a music store's data using SQL. The database schema represents a digital music store where we manage information about customers, employees, invoices, artists, albums, tracks, playlists, and genres.

# 🗂 Database Schema (ER Diagram)
The schema models a music store with relationships between artists, albums, tracks, invoices, and customers.

## Key Tables:
* Artist: Stores artist information (ArtistId, Name).
* Album: Albums linked to artists (AlbumId, Title, ArtistId).
* Track: Tracks in each album with details (TrackId, Name, AlbumId, GenreId, MediaTypeId, Milliseconds, UnitPrice).
* Genre: Music genre details (GenreId, Name).
* MediaType: Format of music (MediaTypeId, Name).
* Playlist & PlaylistTrack: Handles user playlists.
* Customer: Customer details (CustomerId, FirstName, LastName, Country, etc.).
* Employee: Employee details and reporting structure.
* Invoice & InvoiceLine: Purchases made by customers and their details.

The ER diagram shows the relationships:
* One artist has many albums.
* One album has many tracks.
* Tracks belong to genres and media types.
* Customers purchase tracks via invoices and invoice lines.
* Employees manage customers.

## 📊 SQL Queries & Business Insights
The SQL file (Music_Store_Project.sql) contains queries that answer common business and analytical questions:
1. Senior Most Employee – Identify the most senior employee based on job title.
2. Countries with Most Invoices – Find top-performing markets.
3. Top 3 Invoice Totals – Retrieve highest value purchases.
4. Best Customer City – Determine city with highest revenue for hosting events.
5. Best Customer – Customer who has spent the most.
6. Rock Music Listeners – Find emails and details of all rock music listeners.
7. Top Rock Artists – Artists with most rock tracks (Top 10).
8. Longest Tracks – Tracks longer than the average length.
9. Customer Spend on Best-Selling Artist – Amount spent by customers on the top artist.
10. Most Popular Genre by Country – Genre with highest purchases per country.
11. Top Customer by Country – Customers who spent the most in each country.

# 🎯 Project Highlights
* Real-world business questions answered through SQL.
* Queries include aggregate functions, window functions, subqueries, CTEs, and joins.
* Demonstrates data analysis & reporting in a retail music environment.
