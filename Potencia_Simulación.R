#Simulación Proyecto

#Importamos la libreria

library(tidyverse) #Solo se utilizará para la graficación

#Continuamos con la creación de las simulaciones, se prosigue a crear las funciones para el cálculo de esta.
## Se decide hacer funciones para no estar limitados por si se quiere analizar otro caso distinto.


valoresCor = function(x, r){ #Hacemos una función para generar las covariables y que tengan la misma propiedad que en el experimento
  len = length(x)/9
  r2 = r**2
  ve = 1-r2
  SD = sqrt(ve)
  e  = rnorm(length(x), mean=0, sd=SD)
  y  = r*x + e
  return(y) #Genera siempre 9 numeros que estan correlacionados a la variable respuesta con un grado de correlacion de 0.3135
}

funcion.simulacion = function(n){
  
  almacen.x1x2 = rep(NA,10000) #Alamcen de la interaccion entre x1 y x2
  
  cor = 0.3135
  
  for (i in 1:length(almacen.x1x2)){ #Cantidad de iteracciones que se van a hacer
    
    x1 = rep_len(1:3, n) #Creacion del factor x1
    
    x2 = (rep_len(rep(1:3, each = 3), n)) #Creacion del factor x2
    
    base = as.data.frame(cbind(x1,x2)) #Creacion del dataframe
    
    base = base %>% 
      
      arrange(x1) %>% 
      
      arrange(x2) %>% 
      
      mutate(y = as.numeric(rnorm(n, mean = rep(c(2,5,3.4,2.2,4.5,4.1,4.2,3.4,3.1),each = n/9), sd = sqrt(0.598)))) #Creamos la variable respuesta mediante simulacion de la distribucion normal con un vector de mu en donde la diferencia del maximo mu y el minimo mu es la diferencia relevante = 3.
    #Ademas la varianza es el cuadrado medio residual del modelo obtenido en el experimento
    
    covariable = valoresCor(base$y, cor)
    
    
    base = base %>% 
      mutate(covariable = covariable) #Agregamos la covariable a nuestro dataframe
    
    p = anova(aov(y~as.factor(x1)*as.factor(x2)+covariable*as.factor(x2),data = base))[4,5] #Calculamos la potencia de la prueba para la interaccion 
    
    p = 1*(p<0.05)
    
    almacen.x1x2[i]= p #Almacenamos cuando se rechazo y cuando no
    
  }
  
  return(mean(almacen.x1x2)) #Devolvemos el promedio de veces rechazadas para tener el beta 
  
}



completa = function(n = c(18,27,36,45,54)){ #Simulacion para variar la cantidad de n en la simulacion
  
  data = list() #lista para guardar la infromacion
  
  for (j in 1:length(n)){ #Las iteraciones para ir filtrando por el n
    
    data[[j]] = c(funcion.simulacion(n = n[j]),n[j]) #Guardamos el valor de la potencia de la prueba ANOVA de la interaccion con su respectivo n
    
  }
  
  data = as.data.frame(do.call("rbind",data)) #Lo guardamos en un dataframe
  
  colnames(data) = c("Potencia","n") #Renombramos las columnas
  
  return(data) #Devolvemos el dataframe final
}


data = completa() #Sacamos el dataframe de la simulacion para ver las potencias de la prueba

data

data.puntos.rojos = data %>% 
  filter(n==45); data.puntos.rojos

data.puntos.gris = data %>% 
  filter(n!=45); data.puntos.gris

require(ggrepel) #Extension de libreria ggplot 

ggplot(aes(x = as.numeric(n), y = as.numeric(Potencia),label = as.numeric(Potencia)),data = data)+#Grafico de anexo 4 o figura 8 en el articulo del experimento
  geom_line(color = "#01a2d9",size = 0.8)+
  geom_point(data = data.puntos.rojos,aes(x=as.numeric(n),y=as.numeric(Potencia)),color = "#014d64",size = 1.5)+
  geom_point(data = data.puntos.gris,aes(x=as.numeric(n),y=as.numeric(Potencia)),color = "grey",size = 1.5)+
  geom_label_repel(data = data.puntos.rojos,aes(x=as.numeric(n),y=as.numeric(Potencia), label = paste("Potencia del diseño actual:",data.puntos.rojos$Potencia)), min.segment.length = 0,
                   box.padding   = 0.1, 
                   point.padding = 0.5,
                   segment.color = 'grey50', ylim = c(0.5, 0.9),xlim = c(40,45))+
  labs(title = (main = paste(
    strwrap("Potencia de la Prueba del ANOVA del Diseño Experimental",width = 80),
    collapse = "\n ")),
    y ="Potencia de la prueba", x = "Tamaño de muestra (n)",subtitle = "Interaccion entre el pH y Temperatura", 
    caption = "Nota. Simulacion realizada con una diferencia relevante de 3 mm segun la escala de la variable respuesta.\                                                                               Elaboracion propia")+
  scale_x_continuous(breaks = c(unique(data$n)))+
  theme_minimal()+
  theme(plot.title = element_text(hjust= 0.5,face = "bold"),plot.subtitle = element_text(hjust = 0.5),plot.caption = element_text(hjust = 0))