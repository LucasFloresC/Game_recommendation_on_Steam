# Game Recommendation On Steam

En este segundo proyecto del bootcamp trabajaremos sobretodo con SQL para extraer las conlusiones numericas a través de Querys y utilizaremos Power Bi para visualizar los resultados.

![cover](Images/cover.png)

# Primeros pasos

## Seleccionar los datasets con los que trabajaremos:
    
En este caso, he seleccionado de **Kaggle** un repositorio llamado *Game recommendations on Steam* el cual contiene más de 41 millones de recomendaciones (reseñas) de usuarios depuradas y preprocesadas procedentes de Steam Store, una de las principales plataformas en línea para la compra y descarga de videojuegos, DLC y otros contenidos relacionados con los juegos.

Este conjunto de datos contiene 4 ficheros:

-   **Games**: Archivo CSV con la tabla de juegos (o complementos) con información sobre clasificaciones, precios en dólares estadounidenses $, fecha de lanzamiento, etc. 
    
-   **Metadata**: Archivo JSON con los detalles extra de los juegos, como descripciones y etiquetas. Este fichero no lo he usado ya que contiene las sinopsis de los juegos y los generos. 

-   **Users**: Archivo CSV con la tabla de perfiles de usuarios que contiene datos publicos sobre el numero de productos comprados, y las reseñas publicadas

-   **Recommendations**: Archivo CSV con la tabla de reseñas de los usuarios donde estos, recomiendan los distintos productos.
    La tabla representa una relacion **many to many** entre la entindad **Games** y la entindad **Users**


## Pequeña exploración del Dataset y transformación de los datos:

Una vez escogido el dataset, a traves de **Python** guardé las distintas entidades en **Dataframes**, y hice un poco de limpieza.
Primero, cree tres nuevas columnas para poder hacer el **split** de la columna **date_release** y quedarme solo año, que posteriormente usaria en SQL. Las otras dos columnas después las eliminé.

A continuación hice un **pd.to_datetime** para transformar los datos de la columna de fechas de objeto a **timestamp** y así poder trabajar bien en SQL. Hice lo mismo con la nueva columna de los años.

Por ultimo, dado que tenia 41 millones de filas. Me centré en los datos des de **2020** a **2023** (fecha hasta donde llegan los datos). De esta manera me saqué esos subsets y adicionalmente, como seguia teniendo muchas filas, cogí un sample de 1 millon para la entindad **recommendations**

![EDA](Images\EDA.png)

Además, para el archivo **metadata**, dado que la columna **tags** estaba formada por listas tube que separar cada elemento de la lista como columna unica para identificar correctamente el genero a través del metodo **explode** y otros mas.

![explode](Images\explode.png)

## Creacion de la base datos en SQL

En esta etapa se crea la base de datos asi como las distintas tablas que necesitaremos en SQL para poder realizar las distintas Querys y además guardaremos los dataframes en archivos csv para poder importarlos a **Power BI**

![CreacionT](Images\CreacionT.png)

![cursor](Images\cursor.png)

# Hipotesis del proyecto

Despues del primer analisis con Python me marqué los siguientes retos a analizar con **SQL**:

- Encontrar top 10 juegos por año **2020, 2021, 2022, 2023**
- Encontrar top 10 peores juegos por año **2020, 2021, 2022, 2023**
- Media de los ratings de esos juegos
- Media de horas jugadas a esos juegos

Las **hipotesis** reales del proyecto despues del analisis en SQL son:

-   Son los juegos mas jugados los mejor valorados? 
-   Los jugadores juegan mas horas a medida que nos acercamos al presente?
-   Se producen mas juegos segun el año? Existe estacionalidad?
 

# SQL

Aquí ya tenemos creada las base de datos y podemos empezar a explorar los datos y sacar las conclusiones numericas en relacion los retos marcados.
Cabe destacar en este apartado, el uso de las **CTE**, ya que hasta entonces casi no las habia usado y las he encontrado de gran utilidad.
Además de los **JOINS** para linkear las tablas y **SubQuerys** para encapsular otras querys y obtener los resultados que esperaba 

![subquery](Images\subquery.png)

![Join](Images\Join.png)



# Visualizaciones

En esta ultima etapa del proyecto, utilizé **Power BI** para sacar resultados visuales del dataset.

La jerarquia utilizada es la siguiente:

![jerarquia](Images\jerarquia.png)



# Resultados

**a)**  Para los retos marcados en SQL como por ejemplo los rankings por año y reseñas, gracias al uso de las CTE vistas mas arriba consegui sacar el top 10 de mejores y peores juegos de cada uno de los años (2020 - 2023). Dejo aqui un ejemplo:

![resultsub](Images\resultsub.png)

También de esos juegos pude ver la distribución de horas por user:

![Joinsu](Images\Joinsu.png)

**b)**  Para las hipotesis:

-   Son los juegos mas jugados los mejor valorados?

    Como podemos ver en Power BI, no siempre. Pero si que existe una tendencia.

-   Los jugadores juegan mas horas a medida que nos acercamos al presente?

    Por raro que parezca, no. Vemos que 2020 y 2022 estan casi a la par en cuanto a horas, pero 2023 está bastante por debajo segun los datos de Steam.

-   Se producen mas juegos segun el año? Existe estacionalidad?

    Observamos que la tendencia es que cada año Steam tiene mas juegos (2023 puede tener datos incompletos porque el dataset llega hasta ahí).
    Vemos una tendencia a partir de 2021 en cuanto a estacionalidad, en el periodo de despues de Navidades y Otoño. No podemos asegurarlo pero, tendría sentido por las campañas de Navidad y la vuelta de Verano.
    Pero hay que tener en cuenta que el sample puede haber afectado en esta distribución.

*ver Power BI file*