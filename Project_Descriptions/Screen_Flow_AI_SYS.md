# 화면 흐름도: AI_SYS

작성일: 2026-04-02  
문서 버전: v1.0

## 1. 문서 목적
이 문서는 AI_SYS의 주요 화면 간 이동 구조를 정의한다.  
사용자 여정 문서가 사용자의 행동과 시스템 반응을 설명한다면, 이 문서는 실제 서비스 화면이 어떤 순서로 전환되고 어디서 분기되는지를 설계 관점에서 정리하는 데 목적이 있다.

## 2. 화면 목록
- Home: 진입 화면, 최근 검색과 복습 우선 항목 제공
- Search: 판례 검색 입력 및 결과 확인 화면
- Result Detail: 판례 요약, 쟁점, 결론, 출처 확인 화면
- Question Link: 관련 문제 풀이 화면
- Wrong Answer Save: 오답 저장 화면
- Review Dashboard: 복습 추천 및 최근 오답 확인 화면
- Error State: 검색 실패, 출처 불완전, 저장 실패 등 예외 안내 상태

## 3. 메인 화면 흐름

### 3.1 기본 사용자 경로
1. 사용자는 Home에서 판례 검색 시작 또는 복습 바로가기를 선택한다.
2. Search에서 키워드나 사건명을 입력하고 검색 결과를 확인한다.
3. Result Detail에서 판례 쟁점, 결론, 시험 포인트, 출처를 확인한다.
4. Question Link에서 관련 문제를 풀며 판례 이해도를 점검한다.
5. Wrong Answer Save에서 틀린 문제나 헷갈린 쟁점을 저장한다.
6. Review Dashboard에서 복습 추천 목록과 최근 오답을 확인한다.

### 3.2 재방문 사용자 경로
1. 사용자는 Home 진입 직후 최근 학습 요약을 확인한다.
2. 복습이 필요한 경우 바로 Review Dashboard로 이동한다.
3. 복습 중 특정 판례가 더 필요하면 Search 또는 Result Detail로 재이동한다.

## 4. 화면별 전이 규칙

### A. Home
- 진입 조건: 첫 실행 또는 재방문 시작점
- 이동 가능 화면:
  - Search
  - Review Dashboard

### B. Search
- 진입 조건: Home에서 판례 검색 시작 선택
- 이동 가능 화면:
  - Result Detail
  - Error State
  - Home

### C. Result Detail
- 진입 조건: Search 결과 중 특정 판례 선택
- 이동 가능 화면:
  - Question Link
  - Search
  - Error State

### D. Question Link
- 진입 조건: Result Detail에서 관련 문제 보기 선택
- 이동 가능 화면:
  - Wrong Answer Save
  - Result Detail
  - Review Dashboard

### E. Wrong Answer Save
- 진입 조건: 문제 풀이 중 오답 저장 선택
- 이동 가능 화면:
  - Review Dashboard
  - Result Detail
  - Error State

### F. Review Dashboard
- 진입 조건: Home에서 복습 바로가기 선택 또는 오답 저장 완료
- 이동 가능 화면:
  - Search
  - Result Detail
  - Question Link
  - Home

### G. Error State
- 진입 조건:
  - 검색 결과 부족
  - 출처 확인 실패
  - 오답 저장 실패
- 이동 가능 화면:
  - Search로 재시도
  - Result Detail로 복귀
  - Home으로 이동

## 5. 예외 분기 흐름

### 5.1 검색 실패 분기
1. Search에서 검색 결과가 충분하지 않으면 Error State를 표시한다.
2. 시스템은 유사 키워드 또는 관련 과목 기준 재검색 옵션을 제공한다.
3. 사용자는 Search로 돌아가 검색어를 수정한다.

### 5.2 출처 불완전 분기
1. Result Detail에서 출처가 충분하지 않으면 경고 상태를 표시한다.
2. 시스템은 단정형 설명보다 관련 후보 판례를 우선 제안한다.
3. 사용자는 Search로 돌아가 다른 판례를 비교할 수 있다.

### 5.3 오답 저장 실패 분기
1. Wrong Answer Save에서 저장 실패 시 Error State를 표시한다.
2. 시스템은 임시 저장 또는 재시도 옵션을 제공한다.
3. 사용자는 저장 성공 후 Review Dashboard로 이동한다.

## 6. 발표용 설명 포인트
- Home은 시작점과 재방문 진입점을 동시에 담당한다.
- Search와 Result Detail은 가장 자주 왕복되는 핵심 학습 구간이다.
- Question Link와 Wrong Answer Save는 단순 정보 조회를 학습 행동으로 전환하는 구간이다.
- Review Dashboard는 학습 종료 화면이 아니라 다음 세션 진입을 준비하는 허브 역할을 한다.

## 7. Mermaid 화면 흐름도

### 7.1 메인 플로우

```mermaid
flowchart LR
  H[Home] --> S[Search]
  H --> R[Review Dashboard]
  S --> D[Result Detail]
  D --> Q[Question Link]
  Q --> W[Wrong Answer Save]
  W --> R
  R --> S
  R --> D
```

### 7.2 예외 포함 플로우

```mermaid
flowchart TD
  H[Home] --> S[Search]
  S -->|검색 성공| D[Result Detail]
  S -->|검색 실패| E[Error State]
  D -->|출처 충분| Q[Question Link]
  D -->|출처 불완전| E
  Q -->|오답 저장 선택| W[Wrong Answer Save]
  Q -->|바로 복습 이동| R[Review Dashboard]
  W -->|저장 성공| R
  W -->|저장 실패| E
  E --> S
  E --> D
  E --> H
```

## 8. 저충실도 전환 맵

```text
[Home]
  |- 판례 검색 시작 -> [Search]
  |- 복습 바로가기 -> [Review Dashboard]

[Search]
  |- 검색 결과 선택 -> [Result Detail]
  |- 결과 없음 -> [Error State]
  |- 뒤로가기 -> [Home]

[Result Detail]
  |- 관련 문제 보기 -> [Question Link]
  |- 다른 판례 비교 -> [Search]
  |- 출처 문제 -> [Error State]

[Question Link]
  |- 오답 저장 -> [Wrong Answer Save]
  |- 상세로 복귀 -> [Result Detail]
  |- 복습 이동 -> [Review Dashboard]

[Wrong Answer Save]
  |- 저장 성공 -> [Review Dashboard]
  |- 저장 실패 -> [Error State]
  |- 취소 -> [Result Detail]

[Review Dashboard]
  |- 복습 항목 선택 -> [Result Detail]
  |- 검색으로 이동 -> [Search]
  |- 홈으로 이동 -> [Home]
```