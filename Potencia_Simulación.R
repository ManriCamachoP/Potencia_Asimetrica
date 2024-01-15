trat.distribucion = function(n, mu, v = 4,
                             iteracion){
  
  k = 9 
  r = n/k 
  
  if ((n-r*iteracion) == 0){
    
    x1 = factor(rep(1:k/2, each = r))
    x2 = factor(rep(1:k/2, each = r))
    
    y = rexp(n = n, rate = rep(1/2,each = r))
  }
  
  if ((n-r*iteracion)!= 0){
    
    y_norm = rnorm(n-(r*iteracion),
                   rep(mu,each=r), sqrt(v))
    
    x1 = factor(rep(1:k/2, each = r))
    x2 = factor(rep(1:k/2, each = r))
    y = c(y_norm,rexp(n = r*iteracion, rate =
                        rep(1/2,each = r)))
  }
  mod = aov(y ~ x1+x2+x1:x2) 
  return(mod$res) 
}


simulacion.completa = function(n.ast =
                                 c(5*9,10*9,15*9,20*9) ,mu_fijo =
                                 c(4,6,2,3,4,3,6,5,4)){
  
  aleatorio = sample(mu_fijo,
                     length(mu_fijo)) 
  lambda = 1/2
  
  data = list()
  
  m = 1 
  
  pruebas = c("Shapiro-Wilks","Jarque-Bera","KS-Lilliefors")
  
  for (k in 1:length(n.ast)){ 
    permitir correr a traves de todas las n
    
    mu = mu_fijo 
    
    for (j in 1:length(mu_fijo)){
      
      almacen.shap = rep(NA,10000)
      
      almacen.jb = rep(NA,10000)
      
      almacen.ksl = rep(NA,10000)
      
      for (i in 1:10000){
        
        residuales =
          trat.distribucion(n.ast[k],mu=mu,iteracion =
                              j)
        
        almacen.shap[i] =
          1*(shapiro.test(residuales)$p.value < 0.05)
        
        almacen.jb[i] =
          1*(jarque.bera.test(residuales)$p.value <
               0.05)


        almacen.ksl[i] =
        1*(lillie.test(residuales)$p.value < 0.05)
        }

    data[[m]] =
    c(pruebas[1],mean(almacen.shap),n.ast[k],j)
    
    m = m + 1
    
    data[[m]] =
    c(pruebas[2],mean(almacen.jb),n.ast[k],j)
    
    m = m + 1
    
    data[[m]] = c(pruebas[3],mean(almacen.ksl),n.ast[k],j)
    
    m = m + 1
    
    mu = mu[-aleatorio[j]]
    }
  }

  data = as.data.frame(do.call("rbind",data))
  
  colnames(data) = c("Normalidad",
  "Potencia", "N", "Distribuciones")
  
    
    return(data) #Devolvemos el dataframe
    final.
}


data = simulacion.completa()
View(data)
