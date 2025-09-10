# -------------------------
# Project Setup Helpers
# -------------------------
setup_go() {
  [[ -z "$1" ]] && { echo "Usage: setup_go <project_name>"; return 1; }
  local PROJECT_NAME="$1"
  mkdir "$PROJECT_NAME" || return 1
  cd "$PROJECT_NAME" || return 1
  go mod init "github.com/beka-birhanu/$PROJECT_NAME"
  git init
  cat > Makefile <<EOF
build:
	@go build -o ./bin/$PROJECT_NAME ./main.go

test:
	go test -v ./...

run: build
	@./bin/$PROJECT_NAME
EOF
  echo -e "bin\n.env\ntmp" > .gitignore
  git add . && git commit -m "init project"
  echo "Go project '$PROJECT_NAME' initialized."
}

setup_servlet() {
  [[ -z "$1" || -z "$2" ]] && { echo "Usage: setup_servlet_project <name> <id>"; return 1; }
  local PROJECT_NAME=$1 PROJECT_ID=$2 PROJECT_DIR="./$PROJECT_NAME"
  mvn archetype:generate -DgroupId=com.example -DartifactId=$PROJECT_NAME \
      -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
  cd "$PROJECT_DIR" || return 1
  git init
  cat > Makefile <<EOF
TARGET_DIR := target
WAR_NAME := $PROJECT_NAME-1.0-SNAPSHOT.war

.PHONY: build run test clean

build: ; @mvn clean package
run:   ; @mvn tomcat7:run
test:  ; @mvn test
clean: ; @mvn clean
EOF
  git add . && git commit -m "init project"
  echo "Servlet project '$PROJECT_NAME' created at $PROJECT_DIR"
  echo "Add Tomcat7 plugin to pom.xml:"
  cat <<'EOF'
<plugins>
  <plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
  </plugin>
</plugins>
EOF
}
