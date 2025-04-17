# 001_trimmed_mean

절사평균(Trimmed Mean) 계산 실습

## 과제 개요

이 과제는 Pandas 라이브러리를 활용하여 고객 데이터(`kopo_customerdata.csv`)의 `TOTAL_AMOUNT` 컬럼에서  
극단값(최소값과 최대값)을 제거한 뒤, 절사평균을 계산하는 과정을 실습합니다.

## 폴더 구조

```txt
001_trimmed_mean/
├── Q2절사평균.drawio # 절사평균 계산 순서도
├── Q2절사평균.ipynb # 절사평균 계산 Jupyter 노트북
└── README.md # 폴더 및 과제 설명 파일
```

## 실행 방법

1. Jupyter Notebook 또는 Google Colab에서 `Q2절사평균.ipynb` 파일을 엽니다.
2. 모든 셀을 순서대로 실행하세요.
3. 데이터 파일(`kopo_customerdata.csv`)은 코드에서 자동으로 다운로드됩니다.

## 절사평균 계산 절차

1. 데이터 불러오기  
  Pandas로 고객 데이터를 불러옵니다.

2. 정렬 및 극단값 확인  
  `TOTAL_AMOUNT` 컬럼을 리스트로 변환 후 정렬합니다.

3. 최소값(0) 제거  
  최소값(0)의 개수(256개)를 확인하고, 모두 제거합니다.

4. 최대값(3,103,500) 제거  
  최대값(3,103,500) 1개를 제거합니다.

5. 절사평균 계산  
  남은 값들의 평균을 구하고, 정수로 변환하여 출력합니다.

## 참고 사항

- 데이터 출처: [kopo_customerdata.csv (GitHub)](https://raw.githubusercontent.com/hyokwan/python-lecture/refs/heads/master/dataset/kopo_customerdata.csv)

- 필요 환경  
  - Python 3.x  
  - pandas 라이브러리
