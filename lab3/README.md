# Laboratorio 3
### Taller Rastering

Universidad Nacional de Colombia\
Computación Visual\
2019-10-27

[//]: # (Alexander Fagua - @alekzu\)
Juan Camilo Vargas - @F1juan


## Discusión

- Inicialmente se desarrolló el rastering básico para familiarizarse con la función de borde para caracterizar determinados puntos respecto al triángulo.
- Aplicando de manera iterativa la función de borde para obtener las coordenadas baricentricas del punto (tal como era explicado en la guía de scratchapixel) se pudo obtener con facilidad los colores del shader a aplicar sobre el triángulo.
- Para implementar el anti-aliasing, se expandió la técnica mostrada en  [scratchapixel](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation). Allí se explica el supersampling con 4 sub muestras por cada pixel, y para observar de manera drástica los efectos sobre la figura, se implementó de manera ajustable, tomando desde 1 muestra (es decir, sin anti-aliasing) hasta 64 muestras por pixel.

Para ilustrar las 3 partes de la práctica como se indica en el enunciado, se pueden ver los resultados de manera progresiva utilizando los comandos adicionales implementados.

#### Comandos adicionales:
- `'q'` Ocultar/mostrar el rastering
- `'w'` Aplicar/remover el shader
- `'x'` Incrementar el factor de supersampling
- `'z'` Reducir el factor de supersampling
