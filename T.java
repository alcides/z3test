import java.util.*;

import com.microsoft.z3.*;

public class T {
  public static void main(String[] args) {
    
    System.out.println(System.getProperty("java.library.path"));
      
    if (args.length == 0) {
      System.out.print("Z3 Full Version String: ");
      System.out.println(Version.getString());
    } else {
      String fname = args[0];
      Log.open(fname + "_java.log");
      checkFile(fname);
      Log.close();
    }
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
      System.out.println("java: " + s.check(e));
      
      System.out.println("java reason: " + s.getReasonUnknown());
    } catch (Z3Exception ex) {
      throw ex;
    }
  }
}