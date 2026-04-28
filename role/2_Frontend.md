# 프론트엔드 (Frontend)

## 개요
AI_SYS의 프론트엔드는 iOS 기반의 모바일 애플리케이션으로, 사용자에게 직관적인 인터페이스를 제공합니다. 로컬 LLM을 통합하여 오프라인 기능도 지원합니다.

---

## 책임사항

### 1. 사용자 인터페이스 설계 및 구현
- SwiftUI를 활용한 UI 개발
- 사용자 경험(UX) 최적화
- 반응형 디자인

### 2. 사용자 경험(UX) 개선
- 직관적인 네비게이션
- 접근성 개선
- 성능 최적화

### 3. 로컬 LLM 통합
- Llama-3.2-1B-Instruct 모델 통합
- 오프라인 추론 지원
- 모델 성능 최적화

### 4. 이미지 인식 (OCR) 기능
- 문서 이미지 캡처
- OCR 처리
- 추출된 텍스트 처리

### 5. 백엔드 API 통신
- REST API 호출
- 네트워크 통신 관리
- 데이터 캐싱

---

## 기술 스택

| 항목 | 기술 |
|------|------|
| **플랫폼** | iOS 14+ |
| **언어** | Swift |
| **UI 프레임워크** | SwiftUI |
| **로컬 LLM** | Llama-3.2-1B-Instruct-Q4_K_M.gguf |
| **네트워킹** | URLSession |

---

## 프로젝트 구조

```
code/ios/
├── project.yml                    # Xcode 프로젝트 설정
├── README.md                      # iOS 설명 문서
├── AISYS.xcodeproj/              # Xcode 프로젝트
│   ├── project.pbxproj
│   └── project.xcworkspace/
└── AISYSApp/
    ├── Sources/
    │   ├── AISYSApp.swift                 # 앱 진입점
    │   ├── AppRuntimeState.swift          # 앱 상태 관리
    │   ├── LLMService.swift               # 로컬 LLM 서비스
    │   ├── LocalLLMEngines.swift          # LLM 엔진 설정
    │   ├── NetworkService.swift           # 백엔드 통신
    │   ├── OCRView.swift                  # 이미지 인식 화면
    │   ├── HomeView.swift                 # 홈 화면
    │   ├── SearchFlowViews.swift          # 검색 플로우
    │   ├── CaseSummaryViewModel.swift     # 케이스 요약 로직
    │   ├── RootTabView.swift              # 탭 네비게이션
    │   ├── NavigationBackButton.swift     # 뒤로가기 버튼
    │   ├── Models.swift                   # 데이터 모델
    │   ├── PromptTemplates.swift          # 프롬프트 템플릿
    │   └── Llama-3.2-1B-Instruct-Q4_K_M.gguf  # LLM 모델 파일
    └── AISYSAppTests/
        └── AISYSAppTests.swift            # 단위 테스트
```

---

## 주요 파일 설명

### `AISYSApp.swift`
- SwiftUI 앱 진입점
- 기본 애플리케이션 구조
- 윈도우 정의

### `AppRuntimeState.swift`
- 앱 전체 상태 관리
- 사용자 세션 추적
- 데이터 공유

### `LLMService.swift`
- 로컬 LLM 모델 로드
- 텍스트 생성 및 추론
- 성능 모니터링

### `NetworkService.swift`
- REST API 호출
- 백엔드 통신
- 에러 처리 및 재시도 로직

### `OCRView.swift`
- 카메라 기능
- 이미지 캡처
- OCR 처리 및 텍스트 추출

### `PromptTemplates.swift`
- LLM 프롬프트 템플릿
- 사용자 입력 템플릿화
- 응답 포맷 정의

---

## 주요 기능

### 1. 홈 화면
- 최근 검색 내역
- 빠른 액세스 메뉴
- 시스템 상태 표시

### 2. 검색 기능
- 키워드 검색
- 필터링 옵션
- 검색 결과 표시

### 3. OCR 기능
- 문서 이미지 촬영
- 텍스트 자동 추출
- 추출된 내용 검토

### 4. 케이스 분석
- 분석 요청
- 실시간 처리
- 결과 표시

### 5. 로컬 LLM 통합
- 오프라인 추론
- 빠른 응답 시간
- 프라이버시 보호

---

## 개발 워크플로우

### 1. 환경 설정
```bash
cd code/ios
open AISYS.xcodeproj
```

### 2. 빌드 및 실행
```bash
xcodebuild build
xcodebuild test
```

### 3. 시뮬레이터 실행
- Xcode에서 원하는 시뮬레이터 선택
- ▶ 버튼으로 실행

### 4. 디바이스 배포
- 실제 iOS 디바이스 연결
- 서명 설정
- 배포 실행

---

## 화면 구조

```
RootTabView (탭 네비게이션)
├── HomeView (홈)
│   ├── 최근 검색
│   └── 빠른 메뉴
├── SearchFlowViews (검색)
│   ├── 검색 입력
│   ├── 검색 결과
│   └── 상세 보기
├── OCRView (이미지 인식)
│   ├── 카메라
│   ├── 텍스트 추출
│   └── 확인 화면
└── CaseSummaryViewModel (분석)
    ├── 분석 요청
    └── 결과 표시
```

---

## 네트워크 통신

### API 엔드포인트
- `GET /api/search?query=keyword` - 검색
- `POST /api/cases/analyze` - 케이스 분석
- `POST /api/permissions/check` - 권한 검증

### 데이터 포맷
- 요청/응답: JSON
- 캐싱: UserDefaults 또는 Core Data

---

## 로컬 LLM 모델

### 모델 정보
- **이름**: Llama-3.2-1B-Instruct
- **크기**: Q4_K_M (양자화)
- **위치**: `AISYSApp/Sources/Llama-3.2-1B-Instruct-Q4_K_M.gguf`

### 로드 및 실행
```swift
let llmService = LLMService()
let response = llmService.generate(prompt: "사용자 입력")
```

---

## 성능 최적화

### 메모리 관리
- 큰 모델 파일 효율적 로드
- 메모리 누수 방지

### 네트워크 최적화
- 요청 배치 처리
- 캐싱 전략
- 타임아웃 관리

### UI 반응성
- 백그라운드 작업 비동기 처리
- 메인 스레드 보호

---

## 상호작용

### 백엔드와의 상호작용
- REST API를 통한 데이터 송수신
- 에러 처리 및 재시도

### AI 모델 설계와의 상호작용
- 로컬 LLM 프롬프트 최적화
- 사용자 입력에 맞춘 템플릿 제공

### 데이터 관리와의 상호작용
- 로컬 데이터 캐시
- 서버 데이터 동기화

---

## 참고 문서
- [iOS 상세 가이드](../code/ios/README.md)
- [실행 가이드](../code/Run_Guide_AI_SYS.md)

---

## 현재 진행 상황 (기준: 2026-04-28)

### 완료 사항 ✅

| 항목 | 상세 |
|------|------|
| 5탭 구조 | Home / OCR / Search / Review / My Page 구현 완료 |
| Home 탭 | 백엔드 대시보드(추천/오답) 로딩 및 실패 폴백 처리 |
| OCR 탭 | PhotosPicker + Vision OCR, 인식 텍스트를 Search 탭으로 전달 |
| Search 탭 | 키워드 검색, 결과 카드, 판례 상세 진입 |
| Case Summary | 요약/퀴즈 생성 트리거 및 상태 표시 |
| Quiz 탭 | 객관식 표시/정답 확인/해설/오답 저장 흐름 |
| Review 탭 | 오답 리스트 조회 |
| My Page 탭 | API 서버 주소 오버라이드 저장/초기화 |
| 뒤로가기 UX | 주요 화면 공통 소형 뒤로가기 버튼 적용 |
| 로컬 LLM | LlamaSwift 연동 경로 확보, 상태 머신(loading/ready/inferring/error) 적용 |
| Rule-based 폴백 | 엔진 실패 시 규칙 기반 fallback으로 UX 보호 |
| API 오버라이드 | UserDefaults 기반 API 서버 주소 오버라이드 지원 |

### 현재 제한 사항 ⚠️

- **네트워크 에러 UX 미흡**: 실패/시간초과/오프라인 케이스별 사용자 메시지 미세분화
- **오답 동기화 미정교화**: 온라인/오프라인 충돌 처리 정책 미완성
- **접근성 미검증**: Dynamic Type, VoiceOver, 대비 검증 및 개선 필요
- **UI 테스트 부족**: 자동화된 UI 테스트/E2E 테스트 미구축

### 다음 작업 (우선순위 순)

1. **[P0]** 실기기(iPhone) E2E 검증 — Home/OCR/Search/요약/퀴즈/오답 전 경로 안정 동작 확인
2. **[P0]** 네트워크 실패/오프라인 케이스 UX 세분화
3. **[P1]** ViewModel 중심 단위 테스트 + 핵심 화면 스모크 테스트 구축
4. **[P1]** 오답 저장 서버 동기화 정책 정교화
5. **[P2]** 접근성 개선 — Dynamic Type, VoiceOver, 색 대비
6. **[P2]** 로딩/에러/빈 상태 디자인 일관화

---

**마지막 업데이트**: 2026-04-28
