list2shape = function(list){
  shapeFrame = data.frame(matrix(nrow = length(list),ncol = length(list[[1]])))
  colnames(shapeFrame)= names(list[[1]])
  for (i in 1:length(list)){
    shapeFrame[i,]=unlist(list[[i]])
  }
  shapeFrame$lo = as.numeric(shapeFrame$lo)
  shapeFrame$la = as.numeric(shapeFrame$la)
  shapeFrame$ba = as.numeric(shapeFrame$ba)
  shapeFrame$da = as.numeric(shapeFrame$da)
  shapeFrame$bx = as.numeric(shapeFrame$bx)
  shapeFrame$dx = as.numeric(shapeFrame$bx)
  coordinates(shapeFrame) =~lo+la
  return(shapeFrame)
}