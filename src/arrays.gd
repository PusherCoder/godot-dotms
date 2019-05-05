const X_D = 45
const Y_D = 50

var circular_vectors = [
 [ Vector2(X_D,0), Vector2(-X_D,0), Vector2(0,Y_D), Vector2(0,-Y_D) ],
 [ Vector2(X_D,0), Vector2(-X_D,0), Vector2(0,Y_D), Vector2(0,-Y_D),
   Vector2(X_D,Y_D), Vector2(-X_D,Y_D), Vector2(X_D,-Y_D), Vector2(-X_D,-Y_D),
   Vector2(2*X_D,0), Vector2(-2*X_D,0), Vector2(0,2*Y_D), Vector2(0,-2*Y_D) ],
 [ Vector2(X_D,0), Vector2(-X_D,0), Vector2(0,Y_D), Vector2(0,-Y_D),
   Vector2(X_D,Y_D), Vector2(-X_D,Y_D), Vector2(X_D,-Y_D), Vector2(-X_D,-Y_D),
   Vector2(2*X_D,0), Vector2(-2*X_D,0), Vector2(0,2*Y_D), Vector2(0,-2*Y_D),
   Vector2(2*X_D,Y_D), Vector2(-2*X_D,Y_D), Vector2(2*X_D,-Y_D), Vector2(-2*X_D,-Y_D),
   Vector2(X_D,2*Y_D), Vector2(-X_D,2*Y_D), Vector2(X_D,-2*Y_D), Vector2(-X_D,-2*Y_D),
   Vector2(2*X_D,2*Y_D), Vector2(-2*X_D,2*Y_D), Vector2(2*X_D,-2*Y_D), Vector2(-2*X_D,-2*Y_D),
   Vector2(3*X_D,0), Vector2(-3*X_D,0), Vector2(0,3*Y_D), Vector2(0,-3*Y_D) ]
]
