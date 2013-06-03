
Google Web Toolkit Compiler Collection

  com.google.gwt.dev.Compiler

Runs with 

  java -jar gwtcc-*.jar

Overview

  http://blog.syntelos.com/2012/11/getting-to-know-gwt-compiler.html

Development

  The objective, here, is to separate a minimal GWTC for compiling
  Java to JavaScript.  In particular, to avoid GWT RPC and other user
  extensions to browser JavaScript.  User extensions should be
  separate from the compiler.

  Notable inclusions are DOM, HTML and ARIA -- as standard components
  of the browser target runtime.

