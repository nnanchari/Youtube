def k_most(n,x):
   out=[]
   d={}
   for num in n: d[num]=d.get(num,0)+1
           
   print(d) 
   return [k for k,v in d.items() if v>=x]
print(k_most([1,2,3],2))
