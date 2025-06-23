# Docker Hub에서 openjdk라는 이름의 공식 이미지 중 17버전을 가져와서 그걸 기반으로 새 이미지를 만든다는 의미.
# 이건 운영체제 + JDK 17이 깔려 있는 셋업 (기초환경)
FROM openjdk:17

# /tmp 디렉토리를 외부 볼륨처럼 설정함 (Spring Boot에서 임시 파일 저장소 용도)
# 컨테이너가 재시작되더라도 /tmp 디렉토리의 데이터는 유지되거나 외부 저장소와 연결해서 사용 가능
VOLUME /tmp

# 로컬의 target/ 디렉토리의 jar 파일을 컨테이너에 복사함(Maven으로 빌드 한 결과물을 집어넣음)
COPY target/springboot-reactjs-backend.jar springboot-reactjs-backend.jar

# java -jar /springboot-reactjs-backend.jar --spring.profiles.active=prod 라는 명령어를 실행.
    # java: 자바 어플리케이션을 실행 할 명령어
    # -jar: JAR(Java ARchive) 파일을 main-class를 찾아 실행시킴
        # jar 파일이란 => 클래스와 라이브러리를 한데 묶은 실행 가능한 패키지라고 보면 됨
    # /springboot-reactjs-backend.jar: 실행 할 jar 파일의 실제 경로
        # Docker Image 의 루트 디렉터리에 COPY 명령어로 복사되어 있었음
    # --spring.profiles.active=prod:
        # application-prod.properties 혹은 application-prod.yml 이라는 설정 파일을 기준으로 컴파일해라
        # 이를 통해 데이터베이스 연결, 로깅 수준, CORS 정책 등 환경 별 설정을 분리 가능함.
ENTRYPOINT ["java","-jar","/springboot-reactjs-backend.jar","--spring.profiles.active=prod"]