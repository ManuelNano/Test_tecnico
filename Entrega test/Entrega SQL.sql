create database Evaluación_Técnica_Accenture;

use Evaluación_Técnica_Accenture;


SELECT employee_id, last_name, first_name, sum(I.total)
FROM employee E
  INNER JOIN customer C
  ON C.support_rep_id = E.employee_id 
  INNER JOIN invoice I
  ON I.customer_id = C.customer_id
  group by  employee_id
  order by
  I.total Desc;

SELECT AR.artist_id, AR.name, count(P.playlist_id)
FROM artist AR
  INNER JOIN album AL
  ON AL.artist_id = AR.artist_id 
  INNER JOIN track T
  ON T.album_id = AL.album_id
  INNER JOIN playlist_track P
  ON P.track_id = T.track_id
  group by  AR.artist_id
  order by
  P.playlist_id Asc;
  
  SELECT 
  G.genre_id, G.name, sum(I.total) as 'total', 
  rank() over(order by I.total Desc) as 'ranking'
  from genre G
  inner join track T 
  on T.genre_id = G.genre_id
  inner join invoice_line IL
  ON IL.track_id = T.track_id
  inner join invoice I
  on I.invoice_id = IL.invoice_id
  group by  G.genre_id;
 -- order by I.total Desc;
 
 
with tabla_aux as(
select invoice_date, sum(total) as sales_day, date_add(invoice_date, interval 1 day) as invoice_date_yesterday 
from invoice
group by invoice_date)

select I.invoice_id, I.invoice_date, sum(I.total) as sales_day, TA.sales_day as sales_yesterday  
from invoice I
left join tabla_aux TA
on I.Invoice_date = TA.invoice_date_yesterday
group by I.invoice_date;

select I.invoice_id, I.invoice_date, sum(I.total) as sales_day, 
LAG(sum(I.total)) over() as sales_yesterday  
from invoice I
group by I.invoice_date;