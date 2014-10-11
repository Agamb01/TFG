TFG: Trabajo fin de grado
===
Titulo: Diseño y análisis de un procesador tolerante a fallos transitorios compatible con ARM a nivel de 
instrucciones.

Objetivo: El proyecto trata de la implementación de un procesador VHDL segmentado, compatible a nivel de 
instrucciones con un ARM 32 bits.La tolerancia a fallos transitorios, se basará en la detección de fallos 
mediante la replicación triple de módulos, y posterior recuperación del fallo mediante:

1. El modulo triplicado permite conocer el valor correcto de la señal 

2. Volvemos a ejecutar las instrucciones (por ejemplo todos los módulos discrepan) 

3. Reiniciamos el sistema (por ejemplo error en el registro PC) 

El principal objetivo del proyecto es proporcionar el procesador tolerante a fallos, frente a las prestaciones 
del procesador. La planificación del proyecto tiene estrictamente que dedicarle como mínimo un tercio del 
tiempo a la recolección de resultados, por lo que el nivel de segmentación, y el conjunto de instrucciones 
implementadas vendrá limitado por el tiempo disponible.
