

import java.util.StringTokenizer;

public class LibPathManifest {


    public final static String UserDir = System.getProperty("user.dir");


    public static void main(String[] argv){
        boolean once = true;

        for (String arg: argv){
            StringTokenizer strtok = new StringTokenizer(arg,":;");
            final int count = strtok.countTokens();
            for (int cc = 0; cc < count; cc++){

                String pel = Rel(strtok.nextToken());

                if (once)
                    once = false;
                else
                    System.out.print(" ");

                System.out.print(pel);
            }
        }
        System.out.println();
    }

    public final static String Rel(String dirpath){

        if (dirpath.startsWith(UserDir)){

            dirpath = dirpath.substring(UserDir.length());
        }

        dirpath = dirpath.replace('\\','/');

        if (dirpath.startsWith("./"))
            dirpath = dirpath.substring(2);

        while ('/' == dirpath.charAt(0))
            dirpath = dirpath.substring(1);

        return dirpath;
    }
}
