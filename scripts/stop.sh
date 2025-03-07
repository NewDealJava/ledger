# stop.sh

PROJECT_ROOT="/home/ubuntu/app"
JAR_FILE="$PROJECT_ROOT/server-0.0.1-SNAPSHOT.jar"

DEPLOY_LOG="$PROJECT_ROOT/deploy.log"

TIME_NOW=$(date +%c)

if [ ! -f $DEPLOY_LOG ]; then
  touch $DEPLOY_LOG
fi

# 프로젝트 루트 디렉토리가 존재하지 않으면 생성
if [ ! -d $PROJECT_ROOT ]; then
  mkdir -p $PROJECT_ROOT
fi

# 현재 구동 중인 애플리케이션 pid 확인
CURRENT_PID=$(pgrep -f $JAR_FILE)

# 프로세스가 켜져 있으면 종료
if [ -z $CURRENT_PID ]; then
  echo "$TIME_NOW > 현재 실행중인 애플리케이션이 없습니다" >> $DEPLOY_LOG
else
  echo "$TIME_NOW > 실행중인 $CURRENT_PID 애플리케이션 종료 " >> $DEPLOY_LOG
  kill -15 $CURRENT_PID
fi
