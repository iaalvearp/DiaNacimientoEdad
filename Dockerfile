
# 1. Empezamos desde una imagen oficial que ya tiene Java 17 y Maven
FROM maven:3.9-eclipse-temurin-17

# 2. Creamos una carpeta para la app
WORKDIR /app

# 3. Copiamos los archivos de tu proyecto (pom.xml y src/)
COPY . .

# 4. Construimos el proyecto (el 'Build Command')
RUN mvn clean package

# 5. Le decimos a Render qué puerto usa tu app
EXPOSE 8080

# 6. Ejecutamos el servidor (el 'Start Command')
CMD ["mvn", "jetty:run"]