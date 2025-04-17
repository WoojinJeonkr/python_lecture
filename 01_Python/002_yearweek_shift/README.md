# 002_yearweek_shift

연도-주차 계산기 (Year-Week Shift Calculator)

## 개요

이 프로젝트는 ISO 표준 주차 체계를 기반으로 특정 연도-주차 값에서 지정된 주차 수만큼 과거로 이동한 값을 계산하는 함수를 제공합니다.  
isoweek 라이브러리를 활용해 정확한 주차 계산을 구현하였으며 다양한 예외 상황을 처리할 수 있습니다.

## 주요 기능

- 연도-주차 계산: 입력값(yearWeek)에서 weeksBack 주차 전의 날짜 계산
- 예외 처리: 6가지 유형의 입력 오류 및 계산 오류 처리
- 유효성 검증: 연도/주차 범위, 데이터 타입, 음수 값 검증

## 파일 구조

```txt
002_yearweek_shift/
├── 연도주차_함수_작성하기.ipynb # 연도 주차 계산 Jupyter 노트북
├── 함수_작성_시_나왔던_반례.txt # 연도 주차 계산 함수 작성 시 나왔던 반례를 정리해놓은 텍스트 파일
├── 연도주차_함수_동작_순서.txt # 연도 주차 계산 함수 동작 순서를 작성한 텍스트 파일
└── README.md # 프로젝트 설명 파일
```

## 실행 방법

1. Jupyter Notebook 또는 Google Colab에서 `연도주차_함수_작성하기.ipynb` 파일을 엽니다.
2. 모든 셀을 순서대로 실행하세요.

## 참고 자료

- [ISO Week 표준](https://en.wikipedia.org/wiki/ISO_week_date)
- [isoweek 라이브러리](https://github.com/gisle/isoweek)
