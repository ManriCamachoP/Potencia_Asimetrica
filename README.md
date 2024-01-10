# Efecto del Número de Réplicas y Número de Tratamientos en la Potencia de Pruebas de Normalidad

Este proyecto, parte de un estudio en la Escuela de Estadística, Universidad de Costa Rica, analiza el impacto de las distribuciones asimétricas positivas en los valores residuales de un modelo experimental. Se evaluó la potencia de pruebas de bondad de ajuste para verificar el supuesto de normalidad de los residuos. El análisis utiliza pruebas paramétricas y no paramétricas (Shapiro-Wilks, Jarque-Bera y Kolmogorov-Smirnov-Lilliefors) con distintas cantidades de réplicas y variados números de distribuciones asimétricas exponenciales.

## Contenidos

- **docs/:** Contiene el artículo detallando el análisis realizado.
- **Potencia_Simulación.R:** Código de simulación de la potencia de las pruebas.

## Resumen del Artículo

La simulación se llevó a cabo con el propósito de analizar el impacto de las distribuciones asimétricas positivas en los valores residuales de un modelo experimental. Se evaluó la potencia de pruebas de bondad de ajuste para verificar el supuesto de normalidad de los residuos. Se emplearon tanto pruebas paramétricas como no paramétricas (Shapiro-Wilks, Jarque-Bera y Kolmogorov-Smirnov-Lilliefors) con distinta cantidad de réplicas y diversos números de distribuciones asimétricas exponenciales con un determinado parámetro β y mediante diez mil iteraciones.

Los resultados indican que de forma autónoma la prueba de Shapiro-Wilks, en múltiples escenarios, obtuvo una potencia superior a las demás. En cuanto a los tamaños muestrales, se encontró que a mayor tamaño de muestra, mayor potencia; de la misma forma, entre más cantidad de tratamientos con distribución exponencial, se obtiene una potencia de la prueba más alta. Además, la prueba no paramétrica Kolmogorov-Smirnov con corrección de Lilliefors mostró un menor rendimiento en comparación con las otras dos pruebas a lo largo del estudio.

## Integrantes del Proyecto

| Nombre del Estudiante       | Correo Electrónico                |
|-----------------------------|-----------------------------------|
| Manrique Camacho Pochet     | MANRIQUE.CAMACHO@ucr.ac.cr        |
| Amanda Cedeño Guzmán        | AMANDA.CEDENO@ucr.ac.cr           |
| Iván Daniel Rodríguez Cruz   | IVAN.RODRIGUEZCRUZ@ucr.ac.cr      |
| Marie Sofia Villalobos Martínez | MARIE.VILLALOBOS@ucr.ac.cr      |

**Docente Supervisor:**
- PhD Shirley Rojas Salazar (shirley.rojas@ucr.ac.cr)

## Licencia

Este proyecto se encuentra bajo [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT). Consulte el archivo LICENSE para más detalles.
