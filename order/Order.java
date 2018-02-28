import java.util.*;

import com.microsoft.z3.*;

public class Order {
  public static void main(String[] args) {
      
    try {
      HashMap<String, String> cfg = new HashMap<String, String>();
      cfg.put("model", "true");
      
      Context ctx = new Context(cfg);
      
      Expr e = ctx.parseSMTLIB2File("../linux.smt2", 
        new Symbol[0],
        new Sort[0],
        new Symbol[0],
        new FuncDecl[0]);
      Solver s = ctx.mkSolver();
      System.out.println("java: " + s.check(e));
      
      System.out.println("java reason: " + s.getReasonUnknown());
    } catch (Z3Exception ex) {
      throw ex;
    }


  }
  
}