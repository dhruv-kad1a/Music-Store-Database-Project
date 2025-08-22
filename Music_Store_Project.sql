
-- Q1: Who is the senior most employee based on job title?
select * from employee
order by levels desc limit 1

-- Q2: Which countries have the most Invoices? 
 select count(*) as c, billing_country from invoice
 group by billing_country
 order by c desc

-- Q3: What are top 3 values of total invoice?
  select total from invoice
  order by total desc
  limit 3
  
/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */
  select sum(total) as InviceTotal ,billing_city from invoice
  group by billing_city
  order by InviceTotal desc 
  limit 1

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/
 select c.customer_id, c.first_name, c.last_name,sum(total) as total_spending
 from customer c 
 join invoice i 
 on c.customer_id = i.customer_id
 group by c.customer_id
 order by total_spending desc
 limit 1


/* Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A.*/

-- Method 1 

select c.email, c.first_name, c.last_name
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
where track_id in (
	select track_id from track t
	join genre g on t.genre_id = g.genre_id
	where g.name like 'Rock'
)
order by c.email

-- *Method 2 

select distinct c.email as Email , c.first_name as FirstName, c.last_name as LastName, g.name as Name
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on il.track_id = t.track_id
join genre g on t.genre_id = g.genre_id
where g.name like 'Rock'
order by c.email


/* Q7: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands.*/

select ar.artist_id,ar.name, count(ar.artist_id) as number_of_songs
from artist ar 
join album al on ar.artist_id = al.artist_id
join track t on al.album_id = t.album_id
join genre g on t.genre_id = g.genre_id
where g.name like 'Rock'
group by ar.artist_id
order by number_of_songs desc
limit 10


/* Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */


select name,milliseconds
from track
where milliseconds >(
	select avg(milliseconds) as avg_track_length from track
)
order by milliseconds


 -- Q9: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent

with best_selling_artist as( 
	select ar.artist_id as artist_id, 
	ar.name, sum(il.unit_price * il.quantity) as total_sales
	from invoice_line il 
	join track t on il.track_id = t.track_id
	join album a on t.album_id = a.album_id
	join artist ar on a.artist_id = ar.artist_id
	group by 1
	order by total_sales desc
	limit 1
)
select c.customer_id, c.first_name, c.last_name,bsa.name,sum(il.unit_price * il.quantity) as total_sales
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on il.track_id = t.track_id
join album a on t.album_id = a.album_id
join best_selling_artist bsa on bsa.artist_id = a.artist_id
group by 1,2,3,4
order by 5 desc



/* Q10: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

with popular_genre as
(SELECT count(il.quantity) as purchases, c.country, g.name, g.genre_id,
	ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity) desc) AS RowNo 

from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on il.track_id = t.track_id 
join genre g on t.genre_id = g.genre_id
group by 2,3,4
order by 2 asc, 1 desc)
select * from popular_genre where RowNo <= 1



/* Q11: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

with Customter_with_country as
	(
	select c.customer_id, c.first_name, c.last_name,i.billing_country,sum(total) as total_spending,
	row_number() over(partition by i.billing_country order by sum(total) desc) as RowNo
	from customer c 
	join invoice i on c.customer_id = i.customer_id
	group by 1,2,3,4
	order by 4 asc,5 desc
	)
select * from Customter_with_country where RowNo<=1







 