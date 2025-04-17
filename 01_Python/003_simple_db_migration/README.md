# 003_simple_db_migration

Oracle에서 MySQL로 테이블 데이터를 마이그레이션하는 파이썬 예제

## 개요

이 프로젝트는 Oracle 데이터베이스에서 MySQL로 테이블 데이터를 이전하는 파이썬 스크립트 예제입니다.  
SQLAlchemy와 Pandas를 이용해 데이터를 추출하고 적재합니다.  
Ngrok 터널링을 통한 원격 DB 접속 예시를 포함합니다.

## 주요 기능

- Oracle에서 MySQL로 데이터 전송
- 테이블 구조 자동 인식 및 데이터 타입 매핑
- Pandas를 이용한 데이터 추출과 적재

## 폴더 구조

```txt
003_simple_db_migration/
├── Oracle에서_MySQL로_DB_이관하기.ipynb # 파이썬 주피터 노트북 파일
└── README.md # 프로젝트 설명 파일
```

## 실행 방법

1. Jupyter Notebook 또는 Google Colab에서 `Oracle에서_MySQL로_DB_이관하기.ipynb` 파일을 엽니다.
2. 모든 셀을 순서대로 실행하세요.

## 주의사항

- Ngrok 등 터널링 사용 시 포트 개방과 연결 상태를 반드시 확인합니다.
- MySQL Connector/Python 9.0.0, SQLAlchemy 2.0.31, pandas 2.2.2 버전 사용을 권장합니다.

## ## 참고 자료

- [Oracle Instant Client](https://www.oracle.com/database/technologies/instant-client.html)
- [SQLAlchemy 공식 문서](https://www.sqlalchemy.org/)
