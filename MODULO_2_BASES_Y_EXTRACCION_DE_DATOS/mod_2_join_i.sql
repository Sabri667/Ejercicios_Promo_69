USE tienda;
/*Ejercicios Joins I
La tabla customers tiene las siguientes columnas:
customer_number: el número identificativo de las clientas/es. Es un número entero y sirve de clave primaria.
customer_name: el nombre de las empresas en las que trabajan las/los clientas/es. Es una cadena de texto.
contact_last_name: El apellido de la persona de contacto en la empresa cliente. Es una cadena de texto.
contact_first_name: El nombre de la persona de contacto en la empresa cliente. Es una cadena de texto.
phone: El teléfono de la persona de contacto en la empresa cliente. Es una cadena de texto (ya que hay espacios).
address_line1: La dirección (calle, número, etc.) de la empresa cliente. Es una cadena de texto.
address_line2: La dirección de la empresa cliente (si se necesita mas espacio). Es una cadena de texto. Muchas veces está vacía.
city: La ciudad de la empresa cliente. Es una cadena de texto.
state: El estado en el que se encuentra la empresa cliente. Válido para los Estados Unidos. Es una cadena de texto.
postal_code: El código postal. Es una cadena de texto (ya que puede haber espacios).
country: El país de la empresa cliente. Es una cadena de texto.
sales_rep_employee_number: El número identificador de la empleada o empleado que lleva a esa empresa cliente. Es un número entero.
credit_limit: El límite de crédito que tiene la empresa cliente. Es un número decimal.

La tabla Employees tiene las siguientes columnas:
employee_number: el número identificativo de las empleadas/os. Es un número entero y sirve de clave primaria.
last_name: el apellido de las empleadas. Es una cadena de texto.
first_name: el nombre de las empleadas. Es una cadena de texto.
extension: su extensión telefónica. Es una cadena de texto.
email: el correo electrónico de la empleada. Es una cadena de texto.


office_code: El código de la oficina de la empleada. Es una cadena de texto.
reports_to: el número identificativo de la empleada a la que reporta (su supervisora). Es un número entero y clave foránea (relacionada con employeeNumber).
job_title: el nombre del puesto de trabajo que desempeña. Es una cadena de texto.
*/

/*Los ejercicios planteados para hoy son:
Selecciona el ID, nombre, apellidos de las empleadas y el ID de cada cliente asociado a ellas, usando INNER JOIN.*/
SELECT e.employee_number, e.first_name, e.last_name, c.customer_number 
FROM customers c
INNER JOIN employees e
ON e.employee_number=c.sales_rep_employee_number;
/*Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando INNER JOIN.*/
SELECT e.employee_number, e.first_name, e.last_name, c.customer_number, COUNT(c.customer_number) AS total_clientes
FROM customers c
INNER JOIN employees e
ON e.employee_number=c.sales_rep_employee_number
GROUP BY e.employee_number, e.first_name, e.last_name
HAVING COUNT(c.customer_number) > 8;
/*Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando INNER JOIN*/
SELECT e.first_name, e.last_name
FROM customers c
INNER JOIN employees e
ON e.employee_number=c.sales_rep_employee_number
GROUP BY e.employee_number, e.first_name, e.last_name -- sales_rep_employee_number
HAVING COUNT(DISTINCT c.country) > 1;

/*Selecciona el ID, nombre, apellidos de todas las empleadas y el ID de cada cliente asociado a ellas (si es que lo tienen).*/
SELECT e.employee_number, e.first_name, e.last_name, c.customer_number 
FROM employees e
LEFT JOIN customers c
ON e.employee_number=c.sales_rep_employee_number;


/*Selecciona el ID de todos los clientes, y el nombre, apellidos de las empleadas que llevan sus pedidos (si es que las hay).*/
SELECT  c.customer_number, e.first_name, e.last_name
FROM customers c
LEFT JOIN employees e
ON e.employee_number=c.sales_rep_employee_number;

/*Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando LEFT JOIN.*/
SELECT e.employee_number, e.first_name, e.last_name, COUNT(DISTINCT c.customer_number) total_clientes
FROM employees e
LEFT JOIN customers c
ON e.employee_number=c.sales_rep_employee_number
GROUP BY e.employee_number, e.first_name, e.last_name
HAVING total_clientes > 8;

/*Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando RIGHT JOIN.*/
SELECT e.employee_number, e.first_name, e.last_name, COUNT(DISTINCT c.customer_number) total_clientes
FROM  customers c
RIGHT JOIN employees e
ON e.employee_number=c.sales_rep_employee_number
GROUP BY e.employee_number, e.first_name, e.last_name
HAVING total_clientes > 8;

/*Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando LEFT JOIN.*/
SELECT e.first_name, e.last_name
FROM employees e
LEFT JOIN customers c
ON e.employee_number=c.sales_rep_employee_number
GROUP BY e.employee_number, e.first_name, e.last_name
HAVING COUNT(c.country) > 1;


/*Selecciona el ID, nombre, apellidos de las empleadas y el ID de cada cliente asociado a ellas, usando CROSS JOIN.*/
-- CROSS JOIN devuelve tabla con producto cartesiano, incumple con el enunciado.
/*Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando CROSS JOIN.*/
-- CROSS JOIN devuelve tabla con producto cartesiano, incumple con el enunciado.
/*Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando CROSS JOIN.*/
-- CROSS JOIN devuelve tabla con producto cartesiano, incumple con el enunciado.


