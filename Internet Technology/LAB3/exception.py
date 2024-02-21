try:
    x=10
    if(x<100):
     raise Exception("small number")
except Exception as e:
    print("Exception found=",e)
else:
   print("all Godd")