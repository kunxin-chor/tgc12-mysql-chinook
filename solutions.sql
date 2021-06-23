
/* Q1 */
select FirstName, LastName from Employee where Title = "Sales Support Agent";

/* Q2 */
/*  Display all employees hired between 2002 and 2003,
 and display their first name and last name */

 select FirstName, LastName, HireDate from Employee 
 where hireDate between "2002-01-01" and "2003-12-31";

select FirstName, LastName, HireDate from Employee 
 where hireDate >="2002-01-01" and  hireDate <="2003-12-31";

 /* Q3 */
 /* Display all artists that have the word 'Metal' in their name */
 select * from Artist where Name like "%Metal%";

 /* Q4 */
 /* Display all employees who are in sales (sales manager, sales rep etc.) */
 select * from Employee where Title like "%Sales%"

 /* Q5 */
 /*  Display the titles of all tracks which has the genre "easy listening" */
 select Track.Name from Track where GenreId in
     (SELECT GenreId from Genre where Name="Easy Listening")

/* Alternatively... */
select Track.Name from Track join Genre on Track.GenreId = Genre.GenreId
where Genre.Name = "Easy Listening"

/* Find all the GenreId where their title's length is more than 12 */
select GenreId from Genre where char_length(Name) > 12;

/* Display the titles of all tracks which genre is more than 12 character in length */
select Track.Name from Track where GenreId in 
    (select GenreId from Genre where char_length(Name) > 12);

/* Q6 */
select Album.Title, Track.Name, Genre.Name 
    from Album 
    join Track
        on Album.AlbumId = Track.AlbumId
    join Genre
        on Track.GenreId = Genre.GenreId

/* Q7 */
select avg(Total), BillingCountry from Invoice
group by (BillingCountry)

/* Q8 */
select BillingCountry, avg(total) from Invoice
group by (BillingCountry)
having avg(total) > 5.50;

/* Q8b - using subquery */
select avg(Total) from Invoice;

select BillingCountry, avg(total) from Invoice
group by (BillingCountry)
having avg(total) > (select avg(Total) from Invoice);

/* Q9 */
/*  Using the Invoice table, show the average payment made for each customer,
but only for customer reside in Germany 
and only if that customer has paid more than 10 in total
*/
select Invoice.CustomerId, Customer.FirstName, Customer.LastName, avg(Total) from Invoice
join Customer on Invoice.CustomerId = Customer.CustomerId
where Customer.Country = "Germany"
group by Invoice.CustomerId, Customer.FirstName, Customer.LastName
having sum(Total) > 10;

/* Q10 */
/* Display the average length of Jazz song (that is, the genre of the song is Jazz) 
for each album */
select Album.AlbumId, Album.Title, AVG(Track.Milliseconds) / 60000 as "Avg. length in min"
from Album join Track
    on Album.AlbumId = Track.AlbumId
    join Genre 
    on Track.GenreId = Genre.GenreId
where Genre.Name = "Jazz"
group by Album.Albumid, Album.Title;
