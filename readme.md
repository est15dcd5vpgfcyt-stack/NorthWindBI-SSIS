# NorthWind Data Warehouse — Proyecto ETL con SSIS

## 1. Descripción del proyecto

Este proyecto implementa un proceso de integración, transformación y carga de datos (ETL) para construir y actualizar un Data Warehouse a partir de la base de datos transaccional NorthWind OLTP.

La solución utiliza SQL Server, SQL Server Integration Services (SSIS) y SQL Server Agent para automatizar la carga de las dimensiones y de la tabla de hechos.

## 2. Arquitectura de la solución

El flujo de procesamiento es el siguiente:

**NorthWind OLTP → Paquetes SSIS → NorthWind DW → SQL Server Agent**

- **NorthWind OLTP:** base de datos de origen con información transaccional.
- **SSIS:** ejecuta los procedimientos almacenados responsables de cargar las dimensiones y los hechos.
- **NorthWind DW:** almacena los datos organizados para el análisis.
- **SQL Server Agent:** permite programar la ejecución automática del proceso ETL.

## 3. Modelo dimensional

### Dimensiones

- `dim.DimCustomer`: información de clientes.
- `dim.DimDate`: dimensión temporal para analizar las ventas por fecha.
- `dim.DimEmployee`: información de empleados.
- `dim.DimProduct`: información de productos.
- `dim.DimShipper`: información de transportistas.

### Tabla de hechos

- `fact.FactSales`: almacena los registros de ventas para su análisis.

## 4. Paquetes SSIS implementados

### Carga_Dimensiones.dtsx

Ejecuta los procedimientos almacenados que preparan los miembros desconocidos y cargan las dimensiones:

- `etl.usp_Ensure_UnknownMembers`
- `etl.usp_Load_DimDate`
- `etl.usp_Load_DimCustomer`
- `etl.usp_Load_DimEmployee`
- `etl.usp_Load_DimProduct`
- `etl.usp_Load_DimShipper`

### Carga_FactSales.dtsx

Ejecuta el procedimiento:

- `etl.usp_Load_FactSales`

Este procedimiento carga la tabla de hechos `fact.FactSales`.

### Carga_Total.dtsx

Coordina la ejecución del paquete de dimensiones y del paquete de hechos, de modo que la carga de hechos se realice después de la carga de dimensiones.

## 5. Automatización con SQL Server Agent

Se creó el trabajo `Job_Carga_NorthWindDW` para ejecutar el paquete `Carga_Total.dtsx`.

La programación configurada contempla una ejecución diaria a las 02:00. La ejecución automática requiere que SQL Server Agent esté iniciado y que las conexiones y los permisos sean válidos.

## 6. Validación del proceso ETL

Se verificó que las tablas de dimensiones y la tabla de hechos contienen registros.

También se ejecutó una consulta para comprobar las correspondencias entre las claves de `fact.FactSales` y las dimensiones de clientes, productos, empleados y transportistas.

**Resultado:** las cuatro comprobaciones devolvieron cero registros sin correspondencia.

Asimismo, el trabajo de SQL Server Agent se ejecutó manualmente sin reportar errores.

## 7. Tecnologías utilizadas

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL Server Integration Services (SSIS)
- SQL Server Agent
- Visual Studio
- Git y GitHub

## 8. Ejecución y mantenimiento

Para ejecutar el proceso manualmente, se puede ejecutar el paquete `Carga_Total.dtsx` desde el catálogo SSISDB o iniciar el trabajo `Job_Carga_NorthWindDW` desde SQL Server Agent.

Para el mantenimiento del proyecto se recomienda:

1. Revisar el historial de ejecución del Job.
2. Verificar periódicamente los resultados de las cargas.
3. Mantener copias de seguridad de las bases de datos.
4. Documentar los cambios en los paquetes y procedimientos almacenados.
5. Versionar los archivos del proyecto en GitHub.
6. Confirmar si los procedimientos realizan cargas completas o incrementales antes de volver a ejecutarlos.

## 9. Repositorio

Repositorio del Data Warehouse:

https://github.com/est15dcd5vpgfcyt-stack/NorthWind-DW

Repositorio de la base de datos transaccional:

https://github.com/est15dcd5vpgfcyt-stack/NorthWind-OLTP

## 10. Conclusión

Se implementó un proceso ETL para cargar un modelo dimensional de NorthWind, utilizando SSIS para la ejecución de los procedimientos almacenados y SQL Server Agent para la automatización.

Las pruebas realizadas confirmaron que las tablas contienen registros, que las claves revisadas encuentran correspondencia en sus dimensiones y que el trabajo programado puede ejecutarse manualmente sin reportar errores.