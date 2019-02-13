SELECT * FROM CUSTOMERS;


-- ���� ��Ͽ��� ROWNUM�� �߰�.
SELECT ROWNUM AS "NO.",C.*
FROM CUSTOMERS C
;


-- ROWNUM ���� ����
SELECT ROWNUM AS "NO.",C.*
FROM CUSTOMERS C
ORDER BY ROWNUM DESC
;

-- ������������(5) ��ŭ�� ����Ѵ�
SELECT *
FROM (SELECT ROWNUM AS RNUM,C.* 
    FROM CUSTOMERS C 
    ORDER BY ROWNUM DESC)
WHERE RNUM BETWEEN 28 AND 32 
;


SELECT T2.*
FROM (SELECT ROWNUM R2,T.*
    FROM (SELECT ROWNUM AS RNUM,C.* 
        FROM CUSTOMERS C 
        ORDER BY ROWNUM DESC)T) T2
WHERE R2 BETWEEN 1 AND 5
;