-- SQL_TEST_001
-- 전체 축구팀 목록. 이름 오름차순

-- 답 : 
SELECT TEAM_NAME "전체 축구팀 목록"
FROM TEAM
ORDER BY TEAM_NAME
;

-- SQL_TEST_002
-- 포지션 종류(중복제거,없으면 빈공간)

-- 답 : 
SELECT DISTINCT POSITION "포지션 종류"
FROM PLAYER;


-- SQL_TEST_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- nvl2()사용

-- 답 :
SELECT DISTINCT NVL2(POSITION,POSITION,'신입') "포지션 종류" 
FROM PLAYER
;
-- SQL_TEST_004
-- 수원팀(ID: K02)골키퍼

-- 답 :
SELECT PLAYER_NAME 이름
FROM PLAYER 
WHERE POSITION LIKE 'GK' AND TEAM_ID LIKE 'K02'
ORDER BY PLAYER_NAME 
;

-- SQL_TEST_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수

-- 답 : 
SELECT 
    POSITION 포지션, 
    PLAYER_NAME 이름
FROM 
    PLAYER  
--(SELECT TEAM_ID
--FROM PLAYER 
--WHERE TEAM_ID LIKE 'K02')
WHERE PLAYER_NAME LIKE '고%' 
    AND HEIGHT >= 170 
    AND TEAM_ID LIKE 'K02' ;

-- SQL_TEST_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순

-- 답 : 
SELECT 
    (PLAYER_NAME || '선수') 이름, 
    NVL2(HEIGHT,HEIGHT || 'cm','0cm')키 ,
    NVL2(WEIGHT,WEIGHT || 'kg','0kg')몸무게
FROM PLAYER 
WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC;


-- SQL_TEST_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순

-- 답 :
SELECT 
    (PLAYER_NAME || '선수') 이름, 
    NVL2(HEIGHT,HEIGHT || 'cm','0cm')키 ,
    NVL2(WEIGHT,WEIGHT || 'kg','0kg')몸무게,
    ROUND((WEIGHT/(HEIGHT*HEIGHT*0.0001)),2)"BMI 지수"
FROM (SELECT PLAYER_NAME,HEIGHT,WEIGHT
    FROM PLAYER
    WHERE TEAM_ID LIKE 'K02')
ORDER BY HEIGHT DESC;

-- SQL_TEST_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 
--  포지션이 GK 인  선수
-- 팀명, 사람명 오름차순

-- NATURAL JOIN 방식 (구) (비권장)
SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME
FROM PLAYER P , TEAM T
WHERE P.TEAM_ID = T.TEAM_ID AND 'GK' AND P.TEAM_ID IN('K02','K10')
ORDER BY TEAM_NAME ,PLAYER_NAME ASC
;
--------------------------------------------------------
-- INNER JOIN 방식 (신)
SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID = P.TEAM_ID
    --(SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME FROM TEAM WHERE TEAM_ID LIKE IN('K02','K10'))
WHERE P.POSITION LIKE 'GK' AND P.TEAM_ID IN('K02','K10')
ORDER BY TEAM_NAME ,PLAYER_NAME ASC
;

-- SQL_TEST_009
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순

-- 답 :
SELECT TEAM_NAME 팀명, PLAYER_NAME 이름, HEIGHT 키 
FROM (SELECT T.TEAM_ID, T.TEAM_NAME FROM TEAM T WHERE TEAM_ID IN('K02','K10')) A
    JOIN PLAYER P
        ON P.TEAM_ID LIKE A.TEAM_ID
WHERE HEIGHT BETWEEN 180 AND 183
ORDER BY HEIGHT,TEAM_NAME,PLAYER_NAME;

-- SOCCER_SQL_010
-- 모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순

-- 답 : 
SELECT TEAM_NAME, PLAYER_NAME
FROM (SELECT P.TEAM_ID, P.PLAYER_NAME FROM PLAYER P WHERE POSITION IS NULL) P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY TEAM_NAME, PLAYER_NAME;

-- SOCCER_SQL_011
-- 팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력

-- 답 :
SELECT TEAM_NAME , STADIUM_NAME
FROM TEAM T
    JOIN STADIUM S
    ON S.STADIUM_ID LIKE T.STADIUM_ID
;

-- SOCCER_SQL_012
-- 팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오.

-- 답 :
SELECT T.TEAM_NAME 홈팀,C.SCHE_DATE 날짜 , S.STADIUM_NAME 경기장, C.AWAYTEAM_ID 원정팀
FROM  STADIUM S
    JOIN TEAM T
    ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT AWAYTEAM_ID, SCHE_DATE, STADIUM_ID FROM SCHEDULE WHERE SCHE_DATE LIKE '20120317')C
    ON S.STADIUM_ID LIKE C.STADIUM_ID
--WHERE SCHE_DATE LIKE '20120317'
ORDER BY TEAM_NAME
;

SELECT T.TEAM_NAME 홈팀,
        C.SCHE_DATE 날짜 , 
        S.STADIUM_NAME 경기장, 
        (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE C.AWAYTEAM_ID)원정팀
FROM  STADIUM S
    JOIN TEAM T
    ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT AWAYTEAM_ID, SCHE_DATE, STADIUM_ID FROM SCHEDULE WHERE SCHE_DATE LIKE '20120317')C
    ON S.STADIUM_ID LIKE C.STADIUM_ID
--WHERE SCHE_DATE LIKE '20120317'
ORDER BY TEAM_NAME
;

-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

-- 답 :
SELECT PLAYER_NAME 이름, POSITION 포지션, REGION_NAME||' '||TEAM_NAME 팀명,STADIUM_NAME 경기장,SCHE_DATE 경기날짜
FROM TEAM T
    JOIN PLAYER P
    ON T.TEAM_ID LIKE P.TEAM_ID
    JOIN STADIUM S
    ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE C
    ON S.STADIUM_ID LIKE C.STADIUM_ID
WHERE POSITION LIKE 'GK'     
    AND SCHE_DATE LIKE '20120317'
    AND REGION_NAME LIKE '포항'
ORDER BY TEAM_NAME
;



-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오

-- 답 : 
SELECT S.STADIUM_NAME "경기장 이름",
        SC.SCHE_DATE "경기 일정" ,
        (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE SC.HOMETEAM_ID) "홈", 
        (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE SC.AWAYTEAM_ID) "어웨이",
        SC.HOME_SCORE "홈팀 점수", 
        SC.AWAY_SCORE "어웨이팀 점수"
FROM TEAM T
    JOIN STADIUM S
    ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE SC
    ON SC.STADIUM_ID LIKE T.STADIUM_ID
WHERE SC.HOME_SCORE - SC.AWAY_SCORE >= 3
    OR SC.AWAYTEAM_ID LIKE T.TEAM_NAME
ORDER BY SCHE_DATE;

--
SELECT S.STADIUM_ID "경기장 이름",
       C.SCHE_DATE "경기 일정",
       (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE C.HOMETEAM_ID) "홈팀 이름",
       (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE C.AWAYTEAM_ID) "원정팀 이름", 
       C.HOME_SCORE "홈팀 점수", 
       C.AWAY_SCORE "어웨이팀 점수"
FROM STADIUM S
    JOIN TEAM T
    ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT C.AWAY_SCORE,C.AWAYTEAM_ID,C.HOME_SCORE,C.HOMETEAM_ID,C.SCHE_DATE,C.STADIUM_ID
        FROM SCHEDULE C
        WHERE C.HOME_SCORE >= C.AWAY_SCORE + 3) C
    ON C.STADIUM_ID LIKE T.STADIUM_ID
   
;


SELECT *
FROM TEAM;


--STADIUM S
   -- JOIN TEAM T 
   -- ON S.STADIUM_ID LIKE T.STADIUM_ID
   -- JOIN SCHEDULE SC
   -- ON SC.STADIUM_ID LIKE S.STADIUM_ID
   
   
-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20

-- 답 : 
SELECT S.STADIUM_NAME ,S.STADIUM_ID,S.SEAT_COUNT,HOMETEAM_ID,T.E_TEAM_NAME
FROM STADIUM S 
    LEFT JOIN TEAM T
    ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY HOMETEAM_ID
;

-- 답 2 (훨씬 빠름):
SELECT S.STADIUM_NAME "스타디움 이름",
        S.STADIUM_ID 아이디 ,
        S.SEAT_COUNT 좌석수 ,
        S.HOMETEAM_ID"홈팀 아이디", 
        (SELECT T.E_TEAM_NAME FROM TEAM T WHERE T.STADIUM_ID LIKE S.STADIUM_ID) "영문 이름"
FROM STADIUM S
; 