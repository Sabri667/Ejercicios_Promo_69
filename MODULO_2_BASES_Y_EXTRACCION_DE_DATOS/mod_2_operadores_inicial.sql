USE tienda;
/*Ejercicios Operadores Especiales

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

La tabla Offices tiene las siguientes columnas:

office_code: El código de la oficina. Es un número entero y sirve de clave primaria.
city: nombre de la ciudad donde se encuentra la oficina. Es una cadena de texto.
phone: Teléfono de la oficina. Es una cadena de texto.
address_line1: La dirección de la oficina. Es una cadena de texto.
address_line2: La dirección secundaria de la oficina, por si hubiera algún carácter que no cupiera en la columna de la primera dirección. Es una cadena de texto.
state: El estado en que se encuentra dicha oficina (Para el caso de EEUU o países que agreguen otros países). Es una cadena de texto.
country: país en el cual se encuentra la oficina. Es una cadena de texto.
postal_code: El código postal de la oficina. Es una cadena de texto.
territory: Designación geográfica del territorio donde se encuentra dicha oficina. Es una cadena de texto.

*/

/*Selecciona los apellidos que se encuentren en ambas tablas para employees y customers, con alias 'Apellidos'.*/

SELECT * FROM customers;
SELECT * FROM employees;

SELECT c.contact_last_name Apellidos
FROM customers c
UNION ALL 	-- 145 registros vs. union 122 registros
SELECT  e.last_name Apellidos
FROM employees e;

/*Selecciona los nombres con alias 'nombre' y apellidos, con alias 'Apellidos' tanto de los clientes como de los empleados de las tablas employees y customers.*/

SELECT c.contact_first_name Nombre, c.contact_last_name Apellidos
FROM customers c
UNION 	-- = UNION ALL
SELECT  e.first_name Nombre, e.last_name Apellidos
FROM employees e;

/*Selecciona todos los nombres con alias 'nombre' y apellidos, con alias 'Apellidos' tanto de los clientes como de los empleados de las tablas employees y customers.*/
SELECT c.contact_first_name Nombre, c.contact_last_name Apellidos
FROM customers c
UNION ALL -- = UNION
SELECT  e.first_name Nombre, e.last_name Apellidos
FROM employees e;

/*Queremos ver ahora el employee_number como 'Número empleado', first_n_ame como 'nombre Empleado' y last_name como 'Apellido Empleado' para los empleados
 con employee_number: 1002,1076,1088 y 1612.*/
SELECT e.employee_number 'Numero empleado', e.first_name 'Nombre Empleado', e.last_name 'Apellido Empleado'
FROM employees e 
WHERE employee_number IN ('1002','1076','1088','1612');

/*Queremos ver ahora la 'ciudad' y los nombres de las empresas como 'nombre de la empresa ' de la tabla customers, que no estén en: Ireland, France, Germany.*/
SELECT * FROM customers;
SELECT c.city ciudad, c.customer_name 'nombre de la empresa' 
FROM customers c
WHERE c.country NOT IN ('Ireland','France','Germany');
/*Encuentra los campos nombre del cliente y ciudad, de aquellas ciudades de la tabla de customers que terminen en 'on'.*/
SELECT c.customer_name 'nombre de la empresa', c.city ciudad
FROM customers c
WHERE c.city LIKE '%on';

/*Encuentra los campos nombre del cliente, ciudad de aquellas ciudades de la tabla de customers que terminen en 'on' y que unicamente sean de longitud 4.*/
SELECT c.customer_name 'nombre de la empresa', c.city ciudad
FROM customers c
WHERE c.city LIKE '__on';

/*Encuentra el nombre del cliente, primera dirección y ciudad de aquellas ciudades que contengan el número 3 en su dirección postal (o lo que es lo mismo, su primera dirección).*/
SELECT c.customer_name 'nombre de la empresa', c.city ciudad-- , c.postal_code
FROM customers c
WHERE c.postal_code LIKE '%3%';
 
/*Encuentra el nombre del cliente, primera dirección y ciudad de aquellas ciudades que contengan el número 3 en su dirección postal y la ciudad no empiece por T.
Selecciona, haciendo uso de expresiones regulares, los campos nombre del cliente, primera dirección y ciudad. Unicamente en el caso que la dirección postal, posea algún número en dicho campo.
*/
SELECT c.customer_name 'nombre de la empresa', c.address_line1 'primera dirección', c.city ciudad
FROM customers c
WHERE c.postal_code LIKE '%3%' 
AND c.city NOT LIKE ('T%');


SELECT c.customer_name 'nombre de la empresa', c.address_line1 'primera dirección', c.city ciudad
FROM customers c
WHERE c.postal_code LIKE '%3%' 
AND c.city REGEXP '^[^T*]';

SELECT c.customer_name 'nombre de la empresa', c.address_line1 'primera dirección', c.city ciudad
FROM customers c
WHERE c.postal_code LIKE '%3%' 
AND c.city NOT REGEXP '^[T*]';
