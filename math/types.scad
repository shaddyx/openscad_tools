function type(x)=
(
   x==undef?undef
   : floor(x)==x? "int"
   : ( abs(x)+1>abs(x)?"float"
     : str(x)==x?"str"
     : str(x)=="false"||str(x)=="true"?"bool"
     : (x[0]==x[0])&&len(x)!=undef? "arr" // range below doesn't have len
     : let( s=str(x)
         , s2= split(slice(s,1,-1)," : ")
         )
         s[0]=="[" && s[len(s)-1]=="]"
         && all( [ for(x=s2) isint(int(x)) ] )?"range"
        :"unknown"
    )
);

