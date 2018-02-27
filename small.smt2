(declare-sort IVMap)
(declare-sort SVMap)

(declare-datatypes ((General 0)) ((General (G_Boolean (of_G_Boolean Bool)) (G_Integer (of_G_Integer Int)) (G_String (of_G_String String)) (G_Null))))

(declare-datatypes ((Value 0)) ((Value (G (out_G General)) (O (out_O SVMap)) (A (out_A IVMap)) (R (id Int) (type String)))))


(declare-datatypes ((ValueOption 0)) ((ValueOption (NoValue) (SomeValue (of_SomeValue Value)))))


(declare-fun v_dot (Value String) Value)
(declare-fun In_Boolean (Value) Bool)
(declare-fun Good_R (Value) Bool)
(declare-fun v_tt () Value)

(declare-fun O_EQ (Value Value) Value)

(declare-fun ___17 () Value)
(declare-fun c () Value)

(assert (let ((a!1 (G_Boolean (= (v_dot c "id") (G (G_Integer 0))))))
(let ((a!2 (and (Good_R c)
                (= (type c) "Contact")
                (In_Boolean ___17)
                (= (O_EQ ___17 (G a!1)) v_tt))))
  (not (and (=> a!2 (In_Boolean ___17)))))))