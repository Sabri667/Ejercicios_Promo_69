USE northwind;
/*Ejercicios Union Tablas (Joins II)
Empleadas que sean de la misma ciudad:
Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas y sus supervisoras. Concretamente nos piden:
la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?
ubicación='city'*/
SELECT * FROM Employees;

SELECT e.city, e.firstname, e.lastname, er.city, er.firstname, er.lastname
FROM Employees e
LEFT JOIN Employees er
ON  er.employeeid = e.reportsto;

/*El equipo de marketing necesita una lista con todas las categorías de productos, incluso si no tienen productos asociados. 
Queremos obtener el nombre de la categoría y el nombre de los productos dentro de cada categoría. 
Podriamos usar un RIGTH JOIN con 'categories'?, usemos tambien la tabla 'products'.*/

SELECT COUNT(*) FROM Categories;	-- 8 categorias

-- Right join
SELECT c.categoryid, c.categoryname, p.productid, p.productname
FROM Products p
RIGHT JOIN Categories c ON c.categoryid = p.categoryid;
-- Left join (equivalente)
SELECT c.categoryid, c.categoryname, p.productid, p.productname
FROM Categories c
LEFT JOIN Products p ON c.categoryid = p.categoryid;
-- No hay categorias sin productos asociados.

/*Desde el equipo de ventas nos piden obtener una lista de todos los pedidos junto con los datos de las empresas clientes. Sin embargo, 
hay algunos pedidos que pueden no tener un cliente asignado. Necesitamos asegurarnos de incluir todos los pedidos, incluso si no tienen cliente registrado.*/

SELECT o.orderid,o.customerid,c.companyname,c.contactname,c.city,c.region,c.country,c.phone
FROM Orders o
LEFT JOIN Customers c
ON c.customerid=o.customerid;
-- WHERE o.customerid IS NULL; No hay NULLs

/*El equipo de Recursos Humanos quiere saber qué empleadas han gestionado pedidos y cuáles no. 
Queremos obtener una lista con todas las empleadas y, si han gestionado pedidos, mostrar los detalles del pedido.*/

SELECT e.employeeid, e.firstname, e.lastname, o.orderid, o.customerid,o.orderdate, o.requireddate,o.shippeddate,o.shipvia,o.freight,o.shipname,o.shipcountry
FROM Employees e 
LEFT JOIN Orders o
ON e.employeeid=o.employeeid;

/*Desde el área de logística nos piden una lista de todos los transportistas (shippers) y los pedidos que han enviado. 
Queremos asegurarnos de incluir todos los transportistas, incluso si no han enviado pedidos.*/

SELECT * FROM Shippers;
SELECT * FROM Orders; -- 830 orders

SELECT s.*, o.orderid,o.customerid, o.requireddate,o.shippeddate  
FROM Shippers s
LEFT JOIN Orders o
ON o.shipvia=s.shipperid;

/*=== AVANZADO ===*/
/*Muestra todos los productos y, si tienen algún pedido, muestra el ID del pedido y la compañía del cliente.
Pero solo para pedidos realizados en 1997. Si un producto no ha sido pedido en 1997, debe aparecer igual con NULL en pedido y cliente.*/

SELECT * FROM Products;
SELECT * FROM Orders;  -- o.orderdate YYYY-MM-DD 00:00:00

SELECT p.productid,
       o.orderid,
       o.customerid,
       c.companyname
FROM Products p
LEFT JOIN orderdetails od ON p.productid = od.productid
LEFT JOIN Orders o ON od.orderid = o.orderid 
                  AND o.orderdate BETWEEN '1997-01-01' AND '1997-12-31'
LEFT JOIN Customers c ON o.customerid = c.customerid;
