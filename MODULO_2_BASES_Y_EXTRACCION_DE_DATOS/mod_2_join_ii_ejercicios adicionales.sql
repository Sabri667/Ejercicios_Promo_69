USE northwind;

/* 🟡 Ejercicios Intermedios

### 1. Productos sin pedidos
**Objetivo:** Listar todos los productos que nunca han sido pedidos.  
**Campos a mostrar:** `ProductID`, `ProductName`, `SupplierID`.  
**Ayuda:** `LEFT JOIN` entre `Products` y `OrderDetails` + verificar `NULL`. */
SELECT p.ProductID, p.ProductName, p.SupplierID
FROM Products p
LEFT JOIN orderdetails o
ON o.ProductID=p.ProductID
WHERE o.OrderID IS NULL;

/*### 2. Empleados con más de 10 pedidos en 1997
**Objetivo:** Mostrar `EmployeeID`, `FirstName`, `LastName` y la cantidad total de pedidos gestionados durante el año 1997.  
**Filtro:** Solo empleados con más de 10 pedidos en ese año.  
**Ayuda:** `COUNT` y `GROUP BY` + `HAVING`.*/

SELECT e.EmployeeID, e.FirstName, e.LastName, Count(o.OrderID) AS total_pedidos_gestionados_1997
FROM Employees e
LEFT JOIN Orders o 
ON e.EmployeeID=o.EmployeeID
AND OrderDate BETWEEN '1997-01-01'AND'1997-12-31'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) >10;

/*### 3. Cliente con el mayor gasto total
**Objetivo:** Encontrar el cliente que ha gastado más dinero en toda la historia (suma de `UnitPrice * Quantity * (1 - Discount)`).  
**Mostrar:** `CustomerID`, `CompanyName`, `TotalGastado`.  
**Ayuda:** Unir `Customers`, `Orders`, `OrderDetails`; usar `SUM` y `ORDER BY LIMIT 1`.*/



/*### 4. Productos que han sido pedidos por más de 5 clientes distintos
**Objetivo:** Listar `ProductID`, `ProductName` y la cantidad de clientes diferentes que lo compraron.  
**Filtro:** Solo productos con más de 5 clientes distintos.  
**Ayuda:** `COUNT(DISTINCT Customers.CustomerID)` y unir varias tablas.*/

---

/*### 5. Comparativa de ventas por categoría entre 1996 y 1997
**Objetivo:** Mostrar `CategoryName`, `TotalVentas1996`, `TotalVentas1997`, y la diferencia porcentual.  
**Ayuda:** Dos subconsultas o uso de `SUM(CASE WHEN YEAR(...) = ... THEN ... END)`.*/

---

/*## 🔴 Ejercicios Avanzados

### 6. Ranking de empleados por ventas (con función ventana)
**Objetivo:** Mostrar `EmployeeID`, `FirstName`, `LastName`, `TotalVentas` y un ranking (`RANK()`) ordenado por ventas de mayor a menor.  
**Ayuda:** Ventana `RANK() OVER (ORDER BY SUM(...) DESC)`.

---

### 7. Pedidos cuyo valor total supera el promedio de todos los pedidos
**Objetivo:** Listar `OrderID`, `CustomerID`, `FechaPedido`, `TotalPedido`.  
**Filtro:** Solo pedidos cuyo `TotalPedido` sea mayor al promedio de todos los pedidos.  
**Ayuda:** Subconsulta en `WHERE` o `HAVING`.

---

### 8. Empleados que ganan más que el promedio de su ciudad
**Objetivo:** Mostrar `EmployeeID`, `FirstName`, `LastName`, `City`, `Salary` y `PromedioCiudad`.  
**Filtro:** Solo empleados con salario superior al promedio de su propia ciudad.  
**Ayuda:** Subconsulta correlacionada o `JOIN` con una subconsulta agrupada por ciudad.

---

### 9. Productos que nunca se vendieron junto con otro producto específico
**Objetivo:** Dado un `ProductID` (ej. 7 = “Uncle Bob's Organic Dried Pears”), encontrar todos los productos que **nunca** aparecieron en el mismo pedido que él.  
**Ayuda:** Usar `NOT EXISTS` o `EXCEPT` / `NOT IN` con pares de productos.

---

### 10. Vista de resumen mensual (pivot de ventas por categoría)
**Objetivo:** Construir una consulta que muestre, para cada mes del año 1997, las ventas totales de cada categoría en columnas separadas.  
**Formato esperado:**  
| Mes | Bebidas | Condimentos | Confites | Lácteos | … |  
**Ayuda:** `SUM(CASE WHEN Categories.CategoryName = 'Bebidas' THEN ... END)` + agrupación por mes.

---
*/