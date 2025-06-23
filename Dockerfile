# Java 17이 설치 된 기본 이미지(베이스 OS)를 가져옴
FROM openjdk:17
# /tmp 디렉토리를 외부 볼륨처럼 설정함 (Spring Boot에서 임시 파일 저장소 용도)
VOLUME /tmp
# 로컬의 target/ 디렉토리의 jar 파일을 컨테이너에 복사함(Maven으로 빌드 한 결과물을 집어넣음)
COPY target/springboot-reactjs-backend.jar springboot-reactjs-backend.jar
# 컨테이너가 실행될 때 자바 애플리케이션을 prod profile로 실행함
ENTRYPOINT ["java","-jar","/springboot-reactjs-backend.jar","--spring.profiles.active=prod"]