
# Exploración y Análisis

<p>Behavioral Risk Factor Surveillance System (BRFSS) es el principal sistema de encuestas telefónicas relacionadas con la salud a nivel nacional en Estados Unidos, recopila datos estatales sobre los residentes del país en lo que respecta a sus comportamientos relacionados con el riesgo para la salud, las condiciones crónicas de salud y el uso de servicios preventivos. De esta fuente, el usuario 'ALPHIREE' en Kaggle proceso y limpio los registros para obtener el conjunto de datos.</p>

<p>Cabe destacar que el número de registros con algún padecimiento cardiaco en el conjunto de datos corresponde al 8.79 %.</p>


- Correlación: En esta primera imagen, se puede apreciar que entre las variables numéricas, el índice de masa corporal tiene una correlación muy elevada con la masa y talla, lo cual es lógico, ya que se deriva de estos valores para su cálculo. Además, el consumo de frutas también muestra cierta correlación con el consumo de vegetales.

<p align="center">
  <img src="https://github.com/DiegoAMA/Imagenes/blob/76ee706c36cbfcfab51116a24cf086f0a1894fed/Cardiovascular%20Diseases/Correlacion%20heart.PNG"
</p><Br>

- Artritís y Fumador: Las siguientes dos gráficas cuentan el número de personas del conjunto de datos que padecen artritis y/o fuman o no, coloreando de azul los que corresponden a pacientes con enfermedades cardiobasculares; en ambos gráficos, cuando el registro dice que 'SI' padecen artritis o que 'SI' fuman, se ve un pequeño incremento en los casos de personas con padecimiento cardiaco. Pero la prueba de Fisher enmarca que no hay asociación significativa entre las afecciones cardaicas y las variables de ejercicio, cancer de piel, otro tipo de cancer, artrítis, sexo, y si es fumador; y si se encontró asociación para la depresión.  </p><Br>

<p align="center">
  <img src="https://github.com/DiegoAMA/Imagenes/blob/4395e2710acb7f92628590abf117431d1afa6391/Cardiovascular%20Diseases/Artritis%20y%20Smoking.png"
</p><Br>

- Índice de Masa Corporal: El índice de masa corporal de personas con y sin padecimientos cardíacos muestra un comportamiento y valores muy similares; a simple vista en el gráfico no se aprecia una diferencia. Más en la prueba de T-Student y Wilcoox se obtiene suficiente evidencia para rechazazr la hipótesis Nula, por lo que se puede decir que el índice de masa corporal para personas con afecciones cardiacas tienen en promedio un índice de masa corporal mayor a personas que no lo padecen.

<p align="center">
  <img src="https://github.com/DiegoAMA/Imagenes/blob/4395e2710acb7f92628590abf117431d1afa6391/Cardiovascular%20Diseases/BMI.PNG"
</p><Br>

-Edad: El gráfico muestra un incremento en el número de casos de enfermedades cardíacas conforme aumenta la edad. Es evidente que, a mayor edad, mayor es la cantidad de casos detectados. 

<p align="center">
  <img src="https://github.com/DiegoAMA/Imagenes/blob/4395e2710acb7f92628590abf117431d1afa6391/Cardiovascular%20Diseases/Age.PNG"
     width="700" height="450">
</p><Br>

<p> Las variables más destacables para las afecciones cardíacas dentro de la base de datos incluyen la edad, el índice de masa corportal, la depresión y la alimentación (Consumo de fritas y verduras y consumo de alimentos altos en grasa). Aunque el análisis incluye comparaciones adicionales para entender el comportamiento de las enfermedades cardiovasculares respecto a diversas variables, se han mencionado solo las más relevantes para no extender demasiado este apartado. Detalles adicionales sobre otras variables pueden encontrarse en el código de este trabajo.
  </p>
<Br>

