--Consulta 1 — Resumen ejecutivo mensual
--Total facturado
SELECT
  EXTRACT(MONTH FROM fecha_venta) AS mes, 
  SUM(cantidad*precio_unitario) AS Total_facturado
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

--cantidad de pedidos
SELECT
  EXTRACT(MONTH FROM fecha_venta) AS mes,
  COUNT(*) AS total_pedidos
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

--ticket promedio
SELECT
  EXTRACT(MONTH FROM fecha_venta) AS mes,
  AVG(cantidad*precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

--Consulta 2 — Ranking de productos
SELECT
  SUM(cantidad) AS unidades_vendidas,
  SUM(cantidad*precio_unitario) AS Total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY Total_facturado DESC
LIMIT 5;

--Consulta 3 — Clientes recurrentes
SELECT
  id_cliente,
  COUNT(*) AS total_pedidos
  SUM(cantidad*precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1

--Consulta 4 — Meses por encima/por debajo del promedio 
WITH ventas_mensuales AS (
  SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado
  FROM ventas
  GROUP BY EXTRACT(MONTH FROM fecha_venta)
)
SELECT 
  mes,
  total_facturado,
  CASE 
    WHEN total_facturado > (SELECT AVG(total_facturado) FROM ventas_mensuales) THEN 'Por encima'
    ELSE 'Por debajo'
  END AS comparativa_promedio
FROM ventas_mensuales
ORDER BY mes;
