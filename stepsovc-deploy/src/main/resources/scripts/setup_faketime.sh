git clone https://github.com/dileepbapat/faketime.git
cd faketime
gcc -shared -I $JAVA_HOME/include -I /usr/java/jdk1.7.0_05/include/linux/ -m64 jvmfaketime.c  -o libjvmfaketime.so -fPIC
cp libjvmfaketime.so $JAVA_HOME/jre/lib/amd64/
wget http://mirrors.ibiblio.org/pub/mirrors/maven2/javassist/javassist/3.0/javassist-3.0.jar
mv javassist-3.0.jar javassist.jar
javac -classpath .:javassist.jar ClassModifier.java
java -cp .:javassist.jar  ClassModifier
jar -uf $JAVA_HOME/jre/lib/rt.jar  java/
jar -uf $JAVA_HOME/jre/lib/rt.jar  java/
javac -bootclasspath .:$JAVA_HOME/jre/lib/rt.jar -cp . Test.java
java -cp . Test