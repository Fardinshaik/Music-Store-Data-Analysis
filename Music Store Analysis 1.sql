/*Who is the senior most employee based on job title*/
select * from employee 
order by levels desc 
limit 1 

/*Which countries have the most invoices*/
select billing_country, count(invoice_id) as number_of_invoices  from invoice 
group by billing_country 
order by number_of_invoices desc
limit 1

/*What are top 3 values of total invoice*/
select invoice_id, total from invoice 
order by total desc 
limit 3

/*Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals.
 Return both the city name & sum of all invoice totals*/
select customer.customer_id, first_name, last_name, sum(invoice.total) as invoice_total from customer 
inner join invoice
on customer.customer_id=invoice.customer_id 
group by customer.customer_id, first_name, last_name 
order by invoice_total desc
limit 1

/*Who is the best customer? The customer who has spent the most money will be declared the best customer.
Write a query that returns the person who has spent the most money.*/
select billing_city ,sum(total) as total_invoice from invoice
group by billing_city
order by total_invoice desc
limit 1

/*: Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
Return your list ordered alphabetically by email starting with A*/

select distinct first_name,last_name,email, genre.name  from customer 
inner join invoice 
on customer.customer_id=invoice.customer_id 
inner join invoice_line 
on invoice.invoice_id=invoice_line.invoice_id
inner join track 
on invoice_line.track_id= track.track_id 
inner join genre 
on track.genre_id=genre.genre_id
where genre.name = "Rock"
ORDER BY email

/*Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total 7 track count of the top 10 rock bands*/

select artist.name, count(album.artist_id) from artist 
inner join album 
on artist.artist_id=album.artist_id
inner join track 
on album.album_id=track.album_id
inner join genre
on track.genre_id=genre.genre_id
where genre.genre_id = 1 
group by artist.name 
order by  count(album.artist_id) desc

/*Find how much amount spent by each customer on artists? 
Write a query to return customer name, artist name and total spent*/

select distinct first_name, last_name,sum(invoice_line.unit_price*invoice_line.quantity) as total_spent, artist.name from customer
inner join invoice 
on customer.customer_id=invoice.customer_id
inner join invoice_line
on invoice.invoice_id= invoice_line.invoice_id
inner join track
on invoice_line.track_id=track.track_id
inner join album 
on track.album_id=album.album_id
inner join artist 
on album.artist_id=artist.artist_id
group by first_name, last_name,artist.name
order by total_spent desc 

/* We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. 
Write a query that returns each country along with the top Genres.*/ 

select invoice.billing_country,genre.name, sum(invoice_line.quantity*invoice_line.unit_price) as sales from invoice
inner join invoice_line 
on invoice.invoice_id=invoice_line.invoice_id
inner join track 
on invoice_line.track_id=track.track_id
inner join genre 
on track.genre_id= genre.genre_id
group by invoice.billing_country,genre.name
order by invoice.billing_country ASC, sales desc, genre.name ASC