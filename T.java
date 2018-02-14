import java.util.*;

import com.microsoft.z3.*;

public class T {
  public static void main(String[] args) {
    System.out.print("Z3 Major Version: ");
    System.out.println(Version.getMajor());
    System.out.print("Z3 Full Version: ");
    System.out.println(Version.getString());
    System.out.print("Z3 Full Version String: ");
    System.out.println(Version.getFullVersion());
    
    checkFile("linux.txt");
    checkFile("macos.txt");
   
  }
  
  
  public static void setParams(Solver s, Context ctx) {
    int numberAttempt = 0;
    Params params = ctx.mkParams();
    params.add("candidate_models", true);
    params.add("fail_if_inconclusive", false);
    params.add("smt.random_seed", 1391 * numberAttempt);
    if (numberAttempt > 0)
        params.add("timeout", Math.min(1500 + 500 * (numberAttempt - 1), 10000));
    s.setParameters(params);
  }
  
  public static void checkFile(String fname) {
    try {
      HashMap<String, String> cfg = new HashMap<String, String>();
      cfg.put("model", "true");
      
      Context ctx = new Context(cfg);
      
      BoolExpr e = ctx.parseSMTLIB2File(fname, 
        new Symbol[0],
        new Sort[0],
        new Symbol[0],
        new FuncDecl[0]);
      Solver s = ctx.mkSolver();
      setParams(s, ctx);
      System.out.println(fname + " sexpr:" + s.check(e));
      
      System.out.println("Reason: " + s.getReasonUnknown());
    } catch (Z3Exception ex) {
      throw ex;
    }
  }
}